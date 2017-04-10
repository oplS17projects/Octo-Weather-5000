#lang racket
(require racket/date)
(require racket/gui/base)

(define current-forecast '())


; Make the main window frame entitled octo weather 5000
(define frame (new frame% [label "Octo Weather 5000"]))
 
; Make a text message in the frame
;; I plan on making this a loop and displaying the time and date
;; in real time, it currently just diaplys the date and time at
;; the moment the window opens
(define msg-date (new message% [parent frame]
                 [label (date->string (current-date) #t)]))

;; this is a relic of the tutorial I went through to learn gui-lib
;; I am keeping this here for window spacing until I figure out how
;; to display the window in a more appleaing way
(define msg-test (new message% [parent frame]
                      [label "                                 "]))

; Make a button in the main window frame
; allows the user to search for another city or town
(new button% [parent frame]
     [label "Search for another city/town"]
     [callback (lambda (button event)
                 (send dialog show #t))])

; make a button in the main window frame
; closes the application 
(new button% [parent frame]
     [label "I'm done checking the weather"]
     [callback (lambda (button event)
                 (send frame show #f))])

 
; displays main window
(send frame show #t)

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;this does not work but i want to have it close when enter is pressed
;(define pop-up-canvas%
;  (class canvas%
;    (define/override (on-char event)
;      (if (equal? #\return (send event get-key-code)) 1 0))
;    (super-new)))

;(new pop-up-canvas% [parent dialog])
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;; eveything blow this point was part of the tutorial ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; I am keeping it for reference as I build this applications gui ;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Derive a new canvas (a drawing window) class to handle events
;;;(define my-canvas%
;;;  (class canvas% ; The base class is canvas%
    ; Define overriding method to handle mouse events
;;;    (define/override (on-event event)
;;;      (send msg-test set-label "Canvas mouse"))
    ; Define overriding method to handle keyboard events
;;;    (define/override (on-char event)
;;;      (send msg-test set-label "Canvas keyboard"))
    ; Call the superclass init, passing on all init args
;;;    (super-new)))
 
; Make a canvas that handles events in the frame
;;;(new my-canvas% [parent frame])

; messing with buttons
;;(new button% [parent frame]
;;             [label "Pause"]
;;             [callback (lambda (button event) (sleep 5))])

;;;(define panel (new horizontal-panel% [parent frame]))
;;;(new button% [parent panel]
;;;             [label "Left"]
;;;             [callback (lambda (button event)
;;;                         (send msg-test set-label "Left click"))])
;;;(new button% [parent panel]
;;;             [label "Right"]
;;;             [callback (lambda (button event)
;;;                         (send msg-test set-label "Right click"))])

; Create a dialog
;;(define dialog (instantiate dialog% ("New Location")))
 
; Add a text field to the dialog
;;(new text-field% [parent dialog] [label "city/town"])
 
; Add a horizontal panel to the dialog, with centering for buttons
;;(define panel-text (new horizontal-panel% [parent dialog]
;;                                     [alignment '(center center)]))
 
; Add Cancel button to the horizontal panel
;;(new button% [parent panel-text] [label "Cancel"]
;;     [callback (lambda (button event)
;;                 (send dialog show #f))])
; Add Ok button to the horizontal panel
; This button will tell the system the user has input a new location
;;(new button% [parent panel-text] [label "Ok"]
;;     [callback (lambda (button event)
;;                 (send dialog show #f))])
;;(when (system-position-ok-before-cancel?)
;;  (send panel-text change-children reverse))



