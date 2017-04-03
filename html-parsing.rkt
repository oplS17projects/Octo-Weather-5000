#lang racket

(module octo-weather-5000 racket
  (require net/url)
  (require html)
  (require 2htdp/batch-io)

  (define myurl (string->url "http://api.openweathermap.org/data/2.5/forecast?zip=01453,us&APPID=024dd4f2839dc4f02b33965583da944f&mode=xml"))
  (define myport (get-pure-port myurl))
  (define myweather (port->string myport))
  (close-input-port myport)

  (write-file "weather_data.xml" myweather))
  ;;(read-html myport)
  ;;(display-pure-port myport)



  #|
  (define in (open-input-file "index.html"))
 
  ; Some of the symbols in html and xml conflict with
  ; each other and with racket/base language, so we prefix
  ; to avoid namespace conflict.
  (require (prefix-in h: html)
           (prefix-in x: xml))
 
  (define an-html
    (h:read-xhtml
     (open-input-string
      (string-append (port->string myport)))))

  
  ; extract-pcdata: html-content/c -> (listof string)
  ; Pulls out the pcdata strings from some-content.
  (define (extract-pcdata some-content)
    (cond [(x:pcdata? some-content)
           (list (x:pcdata-string some-content))]
          [(x:entity? some-content)
           (list)]
          [else
           (extract-pcdata-from-element some-content)]))
 
  ; extract-pcdata-from-element: html-element -> (listof string)
  ; Pulls out the pcdata strings from an-html-element.
  (define (extract-pcdata-from-element an-html-element)
    (match an-html-element
      [(struct h:html-full (attributes content))
       (apply append (map extract-pcdata content))]
 
      [(struct h:html-element (attributes))
       '()]))
  
  (close-input-port in)
  (printf "~s\n" (extract-pcdata an-html))) |#

(require 'octo-weather-5000)