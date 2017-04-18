#lang racket
(require net/url json 2htdp/batch-io racket/date)
;(provide (all-defined-out))

(define weather%
  (class object%
    (super-new)
    (init-field _zipcode
                [imperial "&units=imperial"]
                [app_id "&APPID=024dd4f2839dc4f02b33965583da944f"]
                [weather_type "weather?"]
                [location "error"]
                [description "[none]"]
                [temp 0]
                [low 0]
                [high 0]
                [pressure 0]
                [humidity 0]
                [cloudiness 0]
                [wind 0]
                [rain 0]
                [snow 0]
                [date "error"])
    (define/public (make_weather)
      (printf "Hello from inside make_weather!\n")
      
      (define myurl (string->url (string-append "http://api.openweathermap.org/data/2.5/" weather_type "zip=" zipcode ",us" app_id imperial)))
      (define myport (get-pure-port myurl))
      (define myweather (port->string myport))
      (close-input-port myport)

      (write-file "weather_data.json" myweather)

      (define weather_data (read-file "weather_data.json"))
      (define weather_data_string (string->jsexpr weather_data))

      (new this% [zipcode zipcode]
      ; define weather data variables with values
      [location (hash-ref weather_data_string 'name)]
      [description (hash-ref (car (hash-ref weather_data_string 'weather)) 'description)]
      [temp (hash-ref (hash-ref weather_data_string 'main) 'temp)]
      [low (hash-ref (hash-ref weather_data_string 'main) 'temp_min)]
      [high (hash-ref (hash-ref weather_data_string 'main) 'temp_max)]
      [pressure (hash-ref (hash-ref weather_data_string 'main) 'pressure)] ; atmospheric pressure (hPa)
      [humidity (hash-ref (hash-ref weather_data_string 'main) 'humidity)]
      [cloudiness (hash-ref (hash-ref weather_data_string 'clouds) 'all)] ; this is a percentage
      [wind (hash-ref (hash-ref weather_data_string 'wind) 'speed)] ; can also get wind direction?

      ; precipitation (in terms of volume in the last 3 hours)
      [rain (if (hash-has-key? weather_data_string 'rain)
                       (hash-ref (hash-ref weather_data_string 'rain) '3h)
                       0)]
      [snow (if (hash-has-key? weather_data_string 'snow)
                       (hash-ref (hash-ref weather_data_string 'snow) '3h)
                       0)]

      ; date weather info was taken (should always be current date)
      [date (date->string (seconds->date (hash-ref weather_data_string 'dt)))])
      
      (printf "Made it to the end on ~a\n" date))))



(define my_weather (new weather% [_zipcode "01453"])) ; will prompt for zipcode 
(send my_weather make_weather)  ; not working? goes through procedure, but doesn't create/update the object
  

#|
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

|#
