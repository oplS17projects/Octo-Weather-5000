#lang racket

(require net/url json racket/date)
(provide (all-defined-out))

; weather class object
(define forecast%
  (class object%
    (super-new)
    (init-field ;location (gotta find a way to get this, and put it somewhere else)
                description
                temp
                low
                high
                pressure
                humidity
                cloudiness
                wind
                rain
                snow
                date)))

; "constructor" - takes a zipcode, produces a list of weather objects
(define (make_forecast zipcode)
  
  ; set dome defaults for getting weather info from API
  (define imperial "&units=imperial")
  (define app_id "&APPID=024dd4f2839dc4f02b33965583da944f")

  ; get JSON info from API
  (define myurl (string->url (string-append "http://api.openweathermap.org/data/2.5/forecast/daily?zip=" zipcode ",us" app_id imperial)))
  (define myport (get-pure-port myurl))
  (define myforecast (port->string myport))
  (close-input-port myport)
  (define forecast_data_string (string->jsexpr myforecast))

  ; make_forecast is now called recursively to create weather objects
  ; and put them in a list called forecast.
  ; this becomes the five day forecast
  (define forecast (make_forecast_recursive (hash-ref forecast_data_string 'list) 0 4))

  ;return forecast
  forecast)

; recursive helper function for making a list of weather objects
(define (make_forecast_recursive list_of_days start end)
  (if (> start end) '()
      (cons (get_weather (car list_of_days)) (make_forecast_recursive (cdr list_of_days) (+ 1 start) end))))

; function for making an individual weather object
(define (get_weather weather_data)
  (define obj (new forecast% 
                   ; set values to weather object member variables
                   ;[location (hash-ref (hash-ref forecast_data_string 'city) 'name)]
                   [description (hash-ref (car (hash-ref weather_data 'weather)) 'description)]
                   [temp (hash-ref (hash-ref weather_data 'temp) 'day)]
                   [low (hash-ref (hash-ref weather_data 'temp) 'min)]
                   [high (hash-ref (hash-ref weather_data 'temp) 'max)]
                   [pressure (hash-ref weather_data 'pressure)] ; atmospheric pressure (hPa)
                   [humidity (hash-ref weather_data 'humidity)]
                   [cloudiness (hash-ref weather_data 'clouds)] ; this is a percentage
                   [wind (hash-ref weather_data 'speed)] ; can also get wind direction
                   
                   ; precipitation (in terms of volume in the last 3 hours)
                   [rain (if (hash-has-key? weather_data 'rain)
                             (hash-ref weather_data 'rain)
                             0)]
                   [snow (if (hash-has-key? weather_data 'snow)
                             (hash-ref weather_data 'snow)
                             0)]
                   
                   ; date weather info was taken (should always be current date)
                   [date (date->string (seconds->date (hash-ref weather_data 'dt)))]))
  ;return the object
  obj)
  

