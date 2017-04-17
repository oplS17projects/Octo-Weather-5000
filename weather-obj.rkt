#lang racket

(provide (all-defined-out))
;; this is a rudimentary object for the weather
;; we will probably need to add some other functionality

(define (make-forecast location ; the city or town given a zip code
                       descrip ; weather descrition from openweather api
                       temp-cur ; current temperature
                       temp-high ; the days highest predicted temperature
                       temp-low ; the days lowest predicted temperature
                       wind ; average wind speed(mph) for the day
                       cloudy ; either a bool or a string not sure what is better
                       humidity) ; % humidity
  (define (get-loc) location)
  (define (get-desc) descrip)
  (define (get-cur) temp-cur)
  (define (get-high) temp-high)
  (define (get-low) temp-low)
  (define (get-wind) wind)
  (define (get-cloudy) cloudy)
  (define (get-humidity) humidity)
  (define (dispatch m)
    (cond ((eq? m 'get-loc) (get-loc))
          ((eq? m 'get-desc) (get-desc))
          ((eq? m 'get-cur) (get-cur))
          ((eq? m 'get-high) (get-high))
          ((eq? m 'get-low) (get-low))
          ((eq? m 'get-wind) (get-wind))
          ((eq? m 'get-cloudy) (get-cloudy))
          ((eq? m 'get-humidity) (get-humidity))
          (else (error "Unknown command" m))))
  dispatch)
