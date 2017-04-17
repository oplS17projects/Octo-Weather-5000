#lang racket

;; this is a rudimentary object for the weather
;; we will probably need to add some other functionality

(define (make-weather temp-high ; the days highest predicted temperature
                       temp-low ; the days lowest predicted temperature
                       percip-chance ; the % chance of percipitation
                       percip-amount; amount of rain or snow fall in inches --- maybe this one isnt realistic
                       wind-speed ; average wind speed(mph) for the day
                       cloudy ; either a bool or a string not sure what is better
                       humidity) ; % humidity
  (define (get-high) temp-high)
  (define (get-low) temp-low)
  (define (get-percip) percip-chance)
  (define (get-percip-amount) percip-amount)
  (define (get-wind) wind-speed)
  (define (get-cloudy) cloudy)
  (define (get-humidity) humidity)
  (define (dispatch m)
    (cond ((eq? m 'get-high) (get-high))
          ((eq? m 'get-low) (get-low))
          ((eq? m 'get-percip) (get-percip))
          ((eq? m 'get-percip-amount) (get-percip-amount))
          ((eq? m 'get-wind) (get-wind))
          ((eq? m 'get-cloudy) (get-cloudy))
          ((eq? m 'get-humidity) (get-humidity))
          (else (error "Unknown command" m))))
  dispatch)


;; We can make a loop here and generate an x amount day forecast using some loop and making a list
;;; length = days the user requests for a forecast
;;; data = apropriate data that raph gets from API.
;;;; not sure in what form this comes in at the time of writing this
(define (forecast-length length data)
  1)
;; As a side note, im not actually sure what happens when we put the object in a list
;; but we will find that out next week