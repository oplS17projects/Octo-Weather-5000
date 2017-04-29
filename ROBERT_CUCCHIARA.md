# OCTO-WEATHER-5000

## Robert Cucchiara
### April 30, 2017

# Overview
The code that I wrote for this project is responsible for handling the GUI in the main function.
While the code is not particularly flashy it is functional and presents the data effectively to the user.

There are a few objects created in the main which are used to set fonts on the gui.
the rest of the code are gui calls to create different windows, panels, buttons, and a text field for user input.

**Authorship note:** All of the code described here was written by my self.

# Libraries Used

This code uses two libraries as well as two racket files:

```
(require (file "weather-obj.rkt"))
(require (file "forecast-obj.rkt"))
(require racket/date)
(require racket/gui/base)
```

* The `weather-obj.rkt` contains the code to create both the object and string intended for output for the single day forecast.
* The `forecast-obj.rkt` contains the code for the forecast object and the output string. The forecast object is responsible for the 5 day forecast.
* `racket/date` a base racket library is used to display the current date and the real time clock.
* The `racket/gui/base` library is the most prevelant in this file and is used to both display info to the user and lets the user interact with the application.

# Key Code Excerpts

**1. Racket objects: The code below creates two objects of the `font` class using the racket implemented objects**
```
(define date-time-font (make-object font% 10.0 'modern 'normal 'normal #f 'default #f 'aligned))
(define loc-font (make-object font% 12.0 'modern 'normal 'bold #f 'default #f 'aligned))
```
These font objects were necessary because the default font on `racket-gui` is small and unappealing. The only way to change this font was with the `racket-font` object. defining these objects at the beginning of the file also made the code look more clean.

**2. Defining frames and windows: `racket-gui` method for creating a window.**
```
(define frame (new frame% [label "OCTO WEATHER 5000"]
                   [width 500]
                   [height 500]
                   [stretchable-width 500]
                   [stretchable-height 500]
                   ))
```
The code above is the form for creating the window displayed to the user. This specific code segment is responsble for producing the main window of the application. by setting the stretchable height and width it ensures that the window when created is contained within this size regardless of what other panels and frames do.

**3. Date and time: OCTO-WEATHER-5000 displays current up to the second time and date to the user**
```
(define msg-date (new message% [parent frame]
                      [label (date->string (current-date))]
                      [font date-time-font]))
(define msg-time (new message% [parent frame]
                      [label (cadr (cdddr (regexp-split #rx" +" (date->string (current-date) #t))))]
                      [font date-time-font]))
(define clock-timer (new timer%
                         [notify-callback (lambda ()
                                            (send msg-date set-label (date->string (current-date)))
                                            (send msg-time set-label
                                                  (cadr (cdddr (regexp-split #rx" +" (date->string (current-date) #t))))))]
                         [interval 1000]))
```   
The first bit of this code that is important is how things are attached to frames. `[parent frame]` makes this `msg-date` object displayed on the main frame that is displayed to the user. This method of calling `[parent %]` where '%' is some object, is how you attach anything to another frame which appears throughout the rest of the main file.
another interesting bit of code was using the biult in regex in conjunction with `racket/date` to pull the desired information out of the `date->string` procedure. `(cadr (cdddr...)` was necessary to grab that time so that it could be displayed and updated in real time.  the time in the resulting string from `date->string` is in the last poistion of the created list.
Everything is tied together and updates at regular one second intervals thanks to the built in capabilities of `racket/gui`'s `timer%` object and setting the interval with `[interval 1000]`. Interval looks for an integer which represents a time in miliseconds.

**4. User input: a `text-field%` object is created and allows the user to enter a zip code to search for the weather.**
```
  (define zip-input 
    (new text-field% 
         [parent get-zip-group]
         [label ""]
         [init-value ""]
         [min-width 5]
         [stretchable-width 5]
         [callback
          (lambda(f ev)
            (define v (send f get-value))
            (unless (string->number v)
              (send f set-value (regexp-replace* #rx"[^0-9]+" v ""))))]))
```
The above code segment sets up the area for the user to enter a zip code and only accepts nubmer characters. 
```
  (define weather-submit-button 
    (new button% 
         [parent get-zip-group]
         [label "Current Weather"]
         [callback  
          (lambda (button event)
            (define zip-code (send zip-input get-value))
            (define forecast (make_weather zip-code))
            (send zip-code-label set-label zip-code)
            (send label-text select-all)
            (send label-text clear)
            (send label-text insert (weather->string forecast)))]))
```
This bit of code takes the text input from the `zip-input` and calls `make_weather` and `weather->string` which are defined in `weather-obj.rkt`. `make_weather` the result of this procedure is creating an object which `weather->string` converts to a string that through the `insert` procedure sends the new string to the output with this line `(send label-text insert (weather->string forecast))`. Insert changes the text for a given label, which in this case is used to output the weather of a specified location in the United States.

**5. Output: the following code uses two gui objects/procedures to display to the user the desired information**
```
(define main-panel (new group-box-panel%
                        [label "Forecast"]
                        [parent frame]
                        [min-height 450]
                        [stretchable-height 450]))
```
This code is just as boring as the creation of the applications window but it is important that this new panel has a parent of the main window which we defined earlier named simply `frame`.
```
(define label-text (new text%))
[send label-text insert (weather->string (make_weather "01854"))]
(define label (new editor-canvas%
                   [parent main-panel]
                   [label "current conditions"]
                   [editor label-text]
                   [min-height 0]))
```
This last code segment creates a `canvas%` object which in `racket/gui` presents a box for displaying text and images. While images were not used in this project it could be implemented in the future should either me or my partner want to continue working on this as a side project. It's default message is set to display the one day forecast of Lowell, Ma via the following line, `[send label-text insert (weather->string (make_weather "01854"))]`. the box that is formed with `canvas%` then displays the data and allows the user to scroll up and down which is important for the five day forecast which is also provided by this application.
