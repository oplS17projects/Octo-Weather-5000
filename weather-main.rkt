#lang racket
(require (file "weather-obj.rkt"))
(require (file "get_weather.rkt"))
(require racket/date)
(require racket/gui/base)

(define current-forecast '())

;; this section is for the font object declarations
;; these are relics of previous iteration, not sure we need them anymore
;; but i am keeping them just in case we do
(define date-time-font (make-object font% 10.0 'modern 'normal 'normal #f 'default #f 'aligned))
(define loc-font (make-object font% 12.0 'modern 'normal 'bold #f 'default #f 'aligned))

; Make the main window frame entitled octo weather 5000
(define frame (new frame% [label "Octo Weather 5000"]
                   [width 500]
                   [height 500]
                   ;[stretchable-width 500]
                   ;[stretchable-height 500]
                   ))

;; This code is respondisble for displaying the date and time.
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

;; This is the panel that most of the information will be displayed on
(define main-panel (new group-box-panel%
                        [label "Forecast"]
                        [parent frame]
                        [min-height 450]
                        [stretchable-height 450]))

(define label-text (new text%))
[send label-text insert "No zip code entered.\nPlease enter a zip code below."]
(define label (new editor-canvas%
                   [parent main-panel]
                   [label "current conditions"]
                   [editor label-text]))

  (define get-zip-group 
    (new group-box-panel%
         [label "Zip Code"]
         [parent main-panel]
         [min-height 100]
         [stretchable-height 100]))

  (define zip-code-label
    (new message%
         [parent get-zip-group]
         [label "No Zip Code Entered"] ))

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

  (define submit-button 
    (new button% 
         [parent get-zip-group]
         [label "Submit"]
         [callback  
          (lambda (button event)
            ;; use internal define over let only because it's easier
            (define zip-code (send zip-input get-value))
            (define forecast  (get-forecast zip-code))
            (send zip-code-label set-label zip-code)
            ;; now insert weather into the editor, but clear it first 
            (send label-text select-all)
            (send label-text clear)
            (send label-text insert (forecast->string forecast)))]))
  (send main-panel show #t)

;; these buttons will change out output in the weather section
;; these do not currently do anything
(define option-panel (new horizontal-panel% [parent main-panel]
                                     [alignment '(center center)]))
(new button% [parent option-panel] [label "One Day"] [horiz-margin 15])
(new button% [parent option-panel] [label "Three Day"] [horiz-margin 15])
(new button% [parent option-panel] [label "Five Day"] [horiz-margin 15])

;; This message will evetually change when we implement searching feature
;(define msg-loc (new message% [parent frame]
 ;                    [label "Lowell, MA"]
  ;                   [font loc-font]
   ;                  [vert-margin 20]))

;; I wanted to create multiple panels depending on the requested forecast.
;; This panel thing is not workiong out how I thought it would, I'm not sure how
;; to remedy this...
;;The below code makes a panel which will display all of the weather data for the given day
;;(define d1weather-panel (new panel% [parent frame]))
;(define d1weather-panel (new panel% [parent frame]      ; this object is not being made,
                             ;[style 'border]            ; I keep getting errors..?
                             ;[enabled #t]
                             ;[vert-margin 0]	 
                             ;[horiz-margin 0]	 
                             ;[border 5]	 
                             ;[spacing 2]	 
                             ;[alignment '(center center)]	 
                             ;[min-width #f]	 
                             ;[min-height #f]	 
                             ;[stretchable-width #f]	 
                             ;[stretchable-height #f]
                             ;))

;(define msg-weather (new message% [parent frame]
;                         [label "High: 87 Low: 59\n Humidity: 5% Wind speed: 6 mph Percipitation: 0% Sunny"]))


; Make a button in the main window frame
; allows the user to search for another city or town
;(new button% [parent frame]
;     [label "Search for another city/town"]
;     [callback (lambda (button event)
;                 (send dialog show #t))]
     ;[vert-margin 50]
;     )

; make a button in the main window frame
; closes the application 
;(new button% [parent frame]
;     [label "I'm done checking the weather"]
;     [callback (lambda (button event)
;                 (send frame show #f))])

 
; displays main window
(send frame show #t)

;; this is a place holder until a function is written in get-weather to produce
;; a weather_data_string which we can use to properly build this
(define (get-forecast zip)
  (make-forecast weather_location
                 weather_description
                 (number->string temp)
                 (number->string temp_max)
                 (number->string temp_min)
                 wind
                 cloudiness
                 humidity))

(define (forecast->string forecast)
  (string-append (forecast 'get-loc) "\nthe temperature is currently "
                 (forecast 'get-cur) "\n" (forecast 'get-desc)
                 "\nHigh: " (forecast 'get-high) "\nLow: "
                 (forecast 'get-low)))
