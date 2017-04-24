#lang racket
(require (file "weather-obj.rkt"))
(require (file "forecast-obj.rkt"))
(require racket/date)
(require racket/gui/base)

;; this section is for the font object declarations
;; these are relics of previous iteration, not sure we need them anymore
;; but i am keeping them just in case we do
(define date-time-font (make-object font% 10.0 'modern 'normal 'normal #f 'default #f 'aligned))
(define loc-font (make-object font% 12.0 'modern 'normal 'bold #f 'default #f 'aligned))

; Make the main window frame entitled octo weather 5000
(define frame (new frame% [label "OCTO WEATHER 5000"]
                   [width 500]
                   [height 500]
                   [stretchable-width 500]
                   [stretchable-height 500]
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

;; this creates the area in the window that the forecast will be displayed
(define label-text (new text%))
[send label-text insert (weather->string (make_weather "01854"))]
(define label (new editor-canvas%
                   [parent main-panel]
                   [label "current conditions"]
                   [editor label-text]
                   [min-height 300]))

;; sets up the area of the main window that prompts the user to enter a zip code
  (define get-zip-group 
    (new group-box-panel%
         [label "Zip Code"]
         [parent main-panel]
         [min-height 100]
         [stretchable-height 100]))

;; this displays on screen the current zip code being searched
  (define zip-code-label
    (new message%
         [parent get-zip-group]
         [label "No Zip Code Entered"] ))

;; this creates the box for the user to type in the zip code
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

; weather button gets current weather data
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

; forecast button gets five day forecast
  (define forecast-submit-button 
    (new button% 
         [parent get-zip-group]
         [label "Five Day Forecast"]
         [callback  
          (lambda (button event)
            (define zip-code (send zip-input get-value))
            (define forecast (make_forecast zip-code))
            (send zip-code-label set-label zip-code)
            (send label-text select-all)
            (send label-text clear)
            (send label-text insert (forecast->string forecast)))]))

   ;; displays the frame which displays the weather and prompts the user
  (send main-panel show #t)

;; displays the application
(send frame show #t)
