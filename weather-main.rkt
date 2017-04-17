#lang racket
(require (file "weather-obj.rkt"))
(require (file "get_weather.rkt"))
(require racket/date)
(require racket/gui/base)

(define current-forecast '())

;; this section is for the font object declarations
(define date-time-font (make-object font% 10.0 'modern 'normal 'normal #f 'default #f 'aligned))
(define loc-font (make-object font% 12.0 'modern 'normal 'bold #f 'default #f 'aligned))

; Make the main window frame entitled octo weather 5000
(define frame (new frame% [label "Octo Weather 5000"]
                   ;[width 250]
                   ;[height 450]
                   ))

;; This message will evetually change when we implement searching feature
(define msg-loc (new message% [parent frame]
                     [label "Lowell, MA"]
                     [font loc-font]
                     [vert-margin 20]))


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

;; I wanted to create multiple panels depending on the requested forecast.
;; This panel thing is not workiong out how I thought it would, I'm not sure how
;; to remedy this...
;;The below code makes a panel which will display all of the weather data for the given day
;;(define d1weather-panel (new panel% [parent frame]))
(define d1weather-panel (new panel% [parent frame]      ; this object is not being made,
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
                             ))

(define msg-weather (new message% [parent frame]
                         [label "High: 87\tLow: 59\nHumidity: 5%\nWind speed: 6 mph\nPercipitation: 0%\nSunny"]
                         [min-height 10]))


; Make a button in the main window frame
; allows the user to search for another city or town
(new button% [parent frame]
     [label "Search for another city/town"]
     [callback (lambda (button event)
                 (send dialog show #t))]
     ;[vert-margin 50]
     )

; make a button in the main window frame
; closes the application 
(new button% [parent frame]
     [label "I'm done checking the weather"]
     [callback (lambda (button event)
                 (send frame show #f))])

 
; displays main window
(send frame show #t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; This is for the search prompt

; Create a dialog box for entering a new town/city
(define dialog (instantiate dialog% ("New Location")))
 
; Add a text field to the dialog
(new text-field% [parent dialog] [label "city/town"])
 
; Add a horizontal panel to the dialog, with centering for buttons
(define panel-text (new horizontal-panel% [parent dialog]
                                     [alignment '(center center)]))
 
; Add Cancel button to the horizontal panel
; when clicked it closes the search window without transmitting data
(new button% [parent panel-text] [label "Cancel"]
     [callback (lambda (button event)
                 (send dialog show #f))])

; Add Ok button to the horizontal panel
; This button will tell the system the user has input a new location
; this button currently only closes the window as back end functionality
; is not yet in place for this to work correctly
(new button% [parent panel-text] [label "Ok"]
     [callback (lambda (button event)
                 (send dialog show #f))])
(when (system-position-ok-before-cancel?)
  (send panel-text change-children reverse))


