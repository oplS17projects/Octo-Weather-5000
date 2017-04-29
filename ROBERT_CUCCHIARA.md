# OCTO-WEATHER-5000

## Robert Cucchiara
### April 30, 2017

# Overview
The code that I wrote for this project is responsible for handling the GUI in the main function.
While the code is not particularly flashy it is functional and presents the data effectively to the user.

There are a few objects created in the main which are used to set fonts on the gui.
the rest of the code are gui calls to create different windows, panels, buttons, and a text field for user input.

# Libraries Used
This code uses two libraries as well as two racket files:

```
(require (file "weather-obj.rkt"))
(require (file "forecast-obj.rkt"))
(require racket/date)
(require racket/gui/base)
```
* The `weather-obj.rkt` contains the code to create both the object and string intended for output for the single day forecast.
* The `forecast-obj.rkt` contains the code for the forecast object and the output string. The forecast object is responsible for the 5 day forecast.
* `racket/date` a base racket library is used to display the current date and the real time clock.
* The `racket/gui/base` library is the most prevelant in this file and is used to both display info to the user and lets the user interact with the application.

# Key Code Excerpts
