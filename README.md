# Octo-Weather-5000

### Statement

Project revolves around implementing a program that gives you relevant weather data and forecast in a practical and useful way. We hope to learn more about APIs, GUI, and information parsing, and that's why this project is interesting on a personal level.

### Analysis

- DATA ABSTRACTION: getting weather from websites/APIs 
- OOP/state-modification: Create weather objects and have them do all the work.
- RECURSION: Use recursion to create and display weather data taken from a list.


### External Technologies
We use a weather API to provide relevant weather information so we can parse through the information appropriately.

### Data Sets or other Source Materials
We are working with data from APIs that were made available to us with the help of racket's net/url library.

**This is an example of JSON data we got from a weather API**
```
{"coord":{"lon":-71.76,"lat":42.53},
"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"base":"stations",
"main":{"temp":45.5,"pressure":1013,"humidity":81,"temp_min":44.6,"temp_max":48.2},"visibility":16093,"wind":{"speed":5.82,"deg":20},"clouds":{"all":90},"dt":1492883760,
"sys":{"type":1,"id":1298,"message":0.0051,"country":"US","sunrise":1492854802,"sunset":1492904281},
"id":4941873,"name":"Leominster","cod":200}
```

**which was then turned into a string**

```
#hasheq((wind . #hasheq((speed . 5.82) (deg . 20))) (visibility . 16093) (name . Leominster) (id . 4941873) (base . stations) (main . #hasheq((humidity . 81) (temp_min . 44.6) (temp_max . 48.2) (temp . 45.5) (pressure . 1013))) (coord . #hasheq((lon . -71.76) (lat . 42.53))) (weather . (#hasheq((id . 500) (description . light rain) (main . Rain) (icon . 10d)))) (sys . #hasheq((id . 1298) (type . 1) (country . US) (sunrise . 1492854802) (sunset . 1492904281) (message . 0.1601))) (dt . 1492883760) (clouds . #hasheq((all . 90))) (cod . 200))

```
We parse through this string to display relevant weather information using mostly hash-table referencing techniques.
This creates a single weather object. A forecast is created from a list of weather objects, each with their own weather information.


### Deliverable and Demonstration

We have an application that delivers the current date, time, weather, and forecast. You can interact and request weather from different areas using the zip code, as well as being able to switch from five day forecast to a more detailed single day forecast.

### Evaluation of Results
**Successfully implemented:**
- The weather is gathered and displayed accurately depending on user's location input.
- Users can interact with the application without any bugs or crashes occuring.

## Architecture Diagram
![alt tag](https://github.com/oplS17projects/Octo-Weather-5000/blob/master/arch-diagram.png)

Main is the driver for this application that will create the output after collating it using the weather/forecast objects. The weather object will be built by taking infomation from a weather API and assigning it to class variables. These variables will be used to store the appropriate information relevant to the user. 

After the weather object has been constructed, main will call an output function which will present the information to the user using a graphical user interface, calling on the weather object for its share of the work. 

For the five day forecast, another object must be built, as the information from the API varies depending on weather we request, current weather or a forecast. A Forecast object is then built by creating mutliple weather objects using recursion, and is then displayed appropriately as a five day forecast.

## Schedule

### First Milestone (Sun Apr 9)
- Know exactly what APIs we will be using, as well as have all the tools to parse the info.
- Create a weather object that holds relevant data
- Create a basic output for testing purposes

### Second Milestone (Sun Apr 16)
- Have an application that displays the weather in your current location with a 5 day forecast
- Have an output using gui-lib

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])

## Group Responsibilities

### Raphael Megali @ramegali
wrote the code necessary to get the relevant weather information extracted. Wrote code for weather object and forecast object to hold extracted weather information.

### Rob Cucchiara @rcucchiara
Created the graphical user interface using the racket-gui library. Wrote most of main and created the flow of information from the objects into strings which were then output on the application. 
