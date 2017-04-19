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
            (define zip-code (send zip-input get-value))
            (define forecast  (make_weather zip-code))
            (send zip-code-label set-label zip-code)
            (send label-text select-all)
            (send label-text clear)
            (send label-text insert (weather->string forecast)))]))
  (send main-panel show #t)

;; these buttons will change out output in the weather section
;; these do not currently do anything
(define option-panel (new horizontal-panel% [parent main-panel]
                                     [alignment '(center center)]))
(new button% [parent option-panel] [label "One Day"] [horiz-margin 15])
(new button% [parent option-panel] [label "Three Day"] [horiz-margin 15])
(new button% [parent option-panel] [label "Five Day"] [horiz-margin 15])

;; displays
(send frame show #t)
