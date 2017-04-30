# Octo-Weather 5000

## Raphael Megali
### Friday April 28, 2017

# Overview
This set of code provides the user with an application that can be used to access current as well as future weather information anywhere in the US. The information provided is useful as well as practical.

This code uses data abstraction to gather data from an API, and uses recursion and object oriented programming to create lists of objects which are used to store weather information to be accessed later. 


# Libraries/API's used
The code uses three libraries:

```
(require net/url)
(require json)
(require racaket/date)
```

* The ```net/url``` library allows the program to make the RESTful call to the **OpenWeather** API. This is how and where we get the relevant weather data.
* The ```json``` library is used to turn the API information into a json expression.
* The ```racket/date``` library is used to convert the date from the API into a proper representation anyone can refer to.

# Key code excerpts

The following discusses some of the procedures and processes I used to complete my part of this program, which, in a nutshell, involved getting the information required and finding a way to store it for access later by other functions. I will discuss my approaches and how I used the ideas and knowledge from UMass Lowell's COMP.3010 Organization of Programming Languages course to implement them.

## 1) Initializing objects
This is the structure I used to create a weather object for holding the relevant weather information:

```
(define forecast%
  (class object%
    (super-new)
    (init-field description
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
```
Though we did not use objects in this format during the course, I enjoyed diving headlong into the Racket documentation and finding out how to make these types of objects in Racket. Seeing this structure is necessary to understand its implementation later.

The fields are all defined with values once the information is gathered from the API. For the five day forecast, a list of these objects were created using recursion. But we'll get to that later!

## 2) Making the API call and getting JSON data
Once a zipcode is provided by the user, it is passed to a procedure that will produce the forecast for us. 
This is how it makes the call to the API (zipcode, app_id and imperial variables being defined prior to the call):
```
  (define myurl (string->url (string-append "http://api.openweathermap.org/data/2.5/forecast/daily?zip=" zipcode ",us" app_id imperial)))
```
That information is turned into a string:
```
(define myport (get-pure-port myurl))
  (define myforecast (port->string myport))
```
Which then becomes a json expression:
```
  (define forecast_data_string (string->jsexpr myforecast))
```
Since this list appears as a hash map when converted by the JSON library, I was able to use hash table referencing techniques to extract the information I needed from this json expression.

## 3) Using Recursion to create the forecast
The five day forecast in our program is represented by a list, where each element of the list is a weather object, as outlined above. I used what I learned throughout the course regarding lists in order to create one recursively.
This is the call to make the forecast (list):
```
(define forecast (if (hash-has-key? forecast_data_string 'list) (make_forecast_recursive (hash-ref forecast_data_string 'list) 0 4)
      empty))
```
This if statement checks to see if a valid zipcode was provided. If it wasn't valid, an empty list will be returned (no forecast). If not, it will call a procedure to make a list recursively.

To better understand the call to ```make_forecast_recursive```, let's take a look at the procedure itself:
```
(define (make_forecast_recursive list_of_days start end)
  (if (> start end) '()
      (cons (get_weather (car list_of_days)) (make_forecast_recursive (cdr list_of_days) (+ 1 start) end))))
```
This procedure takes a ```list_of_days```, which is a list of forecasts for the next five days, each element of the list being a day. The ```start``` and ```end``` variables are used to count the proper amount of days, in this case 5. This procedure will create a list. 

Lists in Racket are made of cons cells, which are pairs of elements. In a list, the second element of each pair will point to the next cons cell in the list, until the list reaches its end. So I start by using *cons* to put together the first day with the rest of the days. *Car* is used to access the first element of the pair, and is sent to the procedure ```get_weather```, which will make the weather object for that day. *Cdr* is used to access the second, or the rest of the list, which is passed as the argument for the recursive call to ```make_forecast_recursive```. 

Once the end of the list is reached, an empty list is returned, and all the weather objects are "cons'd" together to make the forecast!

Using recursion in Racket was something I initially had a difficult time with, but with practice, it became more natural, and I was able to utilize it as a powerful tool.

## 4) Using Data Abstraction to parse through JSON data
Here's a code excerpt on how to get the high and low temperature for a day:
```
[low (hash-ref (hash-ref weather_data 'temp) 'min)]
[high (hash-ref (hash-ref weather_data 'temp) 'max)]
```
This retrieves the ```min``` and ```max``` values from ```temp```, which is retrieved from the json expression ```weather_data```, and assigns those values to the low and high member variables of the weather object. Thus, the weather object is initialized.
This kind of process is repeated for each member variable in the object, and is how I store the information to be accessed later.

## 5) Using Recursion to display the weather data
Finally, I used recursion once again in order to display the weather information to the user. 
Here's the procedure for displaying the forecast:
```
(define (forecast->string forecast)
  (if (empty? forecast) "END OF FORECAST"
      (string-append (get-field date (car forecast)) "\n"
                     (get-field description (car forecast)) "\n"
                     "high: " (number->string (get-field high (car forecast))) "F\n"
                     "low: " (number->string (get-field low (car forecast))) "F.\n"
                     "cloudiness: " (number->string (get-field cloudiness (car forecast))) "%\n"
                     "humidity: " (number->string (get-field humidity (car forecast))) "%\n"
                     "\n*********************************\n" (forecast->string (rest forecast)))))
```
This is another recursive procedure that takes a forecast (the list of weather objects) walks through it, printing out the values within the object as it goes. ```get-field``` is used to access the different member variables within the object. Once the procedure reaches the end of the forecast, it will append all of the information into one long string, which is then displayed to the user. 

This procedure is called from the main driver, which was written by my partner Rob.








