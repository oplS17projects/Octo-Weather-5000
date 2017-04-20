#lang racket
(require net/url json racket/date)
(provide (all-defined-out))

; weather class object
(define weather%
  (class object%
    (super-new)
    (init-field location
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

; "constructor" - takes a zipcode, produces a weather object
(define (make_weather zipcode)

  ; set some defaults for getting weather info from API
  (define imperial "&units=imperial")
  (define app_id "&APPID=024dd4f2839dc4f02b33965583da944f")

  ; get the info from API and turn it from JSON to a parsable string
  (define myurl (string->url (string-append "http://api.openweathermap.org/data/2.5/weather?zip=" zipcode ",us" app_id imperial)))
  (define myport (get-pure-port myurl))
  (define myweather (port->string myport))
  (close-input-port myport)
  (define weather_data_string (string->jsexpr myweather))
  
  ; time to make the object
  (define obj (new weather% 
       ; set values to weather object member variables
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
       [date (date->string (seconds->date (hash-ref weather_data_string 'dt)))]))
  ;return the object
  obj)

(define (weather->string forecast)
  (string-append (get-field description forecast) " in " (get-field location forecast) " today "
                 "\nwith a high of " (number->string (get-field high forecast)) "F and a low of "
                 (number->string (get-field low forecast)) "F.\n"
                 "Current temperature is " (number->string (get-field temp forecast)) "F."))
