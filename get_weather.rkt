#lang racket

(require readline readline/readline)
(require net/url html json 2htdp/batch-io racket/date)
(provide (all-defined-out))

; units of measurement
(define metric "&units=metric")
(define imperial "&units=imperial")

; personal app id for API access
(define app_id "&APPID=024dd4f2839dc4f02b33965583da944f")

; detailed weather for the day versus forecast
(define weather "weather?")
(define forecast "forecast?")

; prompt user for zipcode 
;(printf "Enter US zip code: ")
;(define zipcode (readline "Enter US zip code: "))

;; TEMPORARY ZIPCODE
(define zipcode "01854")

; get weather in JSON format from API
(define myurl (string->url (string-append "http://api.openweathermap.org/data/2.5/" weather "zip=" zipcode ",us" app_id imperial)))
(define myport (get-pure-port myurl))
(define myweather (port->string myport))
(close-input-port myport)

(write-file "weather_data.json" myweather)

(define weather_data (read-file "weather_data.json"))

; get all the weather data into a string format to parse
(define weather_data_string (string->jsexpr weather_data))
;(display weather_data_string)

; define weather data variables with values
(define weather_location (hash-ref weather_data_string 'name))
(define weather_description (hash-ref (car (hash-ref weather_data_string 'weather)) 'description))
(define temp (hash-ref (hash-ref weather_data_string 'main) 'temp))
(define temp_min (hash-ref (hash-ref weather_data_string 'main) 'temp_min))
(define temp_max (hash-ref (hash-ref weather_data_string 'main) 'temp_max))
(define pressure (hash-ref (hash-ref weather_data_string 'main) 'pressure)) ; atmospheric pressure (hPa)
(define humidity (hash-ref (hash-ref weather_data_string 'main) 'humidity))
(define cloudiness (hash-ref (hash-ref weather_data_string 'clouds) 'all)) ; this is a percentage
(define wind (hash-ref (hash-ref weather_data_string 'wind) 'speed)) ; can also get wind direction?

; precipitation (in terms of volume in the last 3 hours)
(define rain (if (hash-has-key? weather_data_string 'rain)
                 (hash-ref (hash-ref weather_data_string 'rain) '3h)
                 0))
(define snow (if (hash-has-key? weather_data_string 'snow)
                 (hash-ref (hash-ref weather_data_string 'snow) '3h)
                 0))

; date weather info was taken (should always be current date)
(define weather_date (date->string (seconds->date (hash-ref weather_data_string 'dt))))



(printf "\nToday's forecast in ")
(display weather_location)
(printf " on ")
(display weather_date)
(printf " is ")
(display weather_description)
(printf " with a high of ")
(display temp_max)
(printf " and a low of ")
(display temp_min)

        





