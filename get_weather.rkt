#lang racket

(require readline readline/readline)
(require net/url html json 2htdp/batch-io)

; units of measurement
(define metric "&units=metric")
(define imperial "&units=imperial")

; personal app id for API access
(define app_id "&APPID=024dd4f2839dc4f02b33965583da944f")

; detailed weather for the day versus forecast
(define details "weather?")
(define forecast "forecast?")

; prompt user for zipcode 
#|(printf "Enter US zip code: ")
(define zipcode (readline "Enter US zip code: "))

; get weather in JSON format from API
(define myurl (string->url (string-append "http://api.openweathermap.org/data/2.5/" details "zip=" zipcode ",us" app_id imperial)))
(define myport (get-pure-port myurl))
(define myweather (port->string myport))
(close-input-port myport)

(write-file "weather_data.json" myweather)|#

(define weather_data (read-file "weather_data.json"))






