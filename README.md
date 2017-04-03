# Octo-Weather-5000

### Statement

Project revolves around implementing a program that will not only give you relevant time and date information, but weather forecast as well in a practical and useful way. We hope to learn more about APIs, information parsing, and web development in general, and that's why this project is interesting on a personal level.

### Analysis

- DATA ABSTRACTION: getting weather from websites/APIs 
- OOP/state-modification: Create a weather object and time object and have them do everything.
- RECURSION: Planning on using recursion to display weather data taken from a list. I'm sure there are other things.


### External Technologies
We plan on using a weather API to provide relevant weather information and parsing the information appropriately.
We are also going to explore Google Geolocation API with the purpose of displaying the weather near the users current location.

### Data Sets or other Source Materials
We will be working with data from APIs that were made available to us. 

**Here's an example of XML data we got from a weather API**

```
<forecast>
 <time from="2017-04-02T15:00:00" to="2017-04-02T18:00:00">
  <symbol number="800" name="clear sky" var="02d"/>
  <precipitation/>
  <windDirection deg="315.002" code="NW" name="Northwest"/>
  <windSpeed mps="3.27" name="Light breeze"/>
  <temperature unit="kelvin" value="284.13" min="283.247" max="284.13"/>
  <pressure unit="hPa" value="999.89"/>
  <humidity value="50" unit="%"/>
  <clouds value="clear sky" all="8" unit="%"/>
 </time>
```
We plan to parse through this kind of data to display relevant weather information using Racket's json-parsing library along with other libraries like xtml-parsing and the net/url library.

We also plan on using Google's Geolocation API once we figure out how to implement it. This will allow the application to get the user's location info, and then we use that to get the weather from our other API.


### Deliverable and Demonstration

We will have an application that will deliver date, time, current weather, and forecast. As for interactions, maybe have charts/graphs that are interactive, as well as being able to switch from five (eight?) day forecast to detailed single day forecast.

### Evaluation of Results
**Success if:**
- The weather and time can be gathered accurately depending on user's location.
- Users can interact with it without having it break.

## Architecture Diagram
![alt tag](https://github.com/oplS17projects/Octo-Weather-5000/blob/master/arch-diagram.png)

MAIN is the driver for this application that will create the output after collating it using the waether object.  The weather object which will be built using html-parsing from a weather API. In addition to that we will use tz-info to display the local time to the user. After the waether object has been constructed, main will call an output function which will present the information to the user using a graphical user interface.

## Schedule

### First Milestone (Sun Apr 9)
- Know exactly what APIs we will be using, as well as have all the tools to parse the info.
- create a waether object that holds relevant data
- create a basic output for testing purposes

### Second Milestone (Sun Apr 16)
- An application that displays the weather in your current location with a 5 day forecast
- Have an output using gui-lib

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])

## Group Responsibilities

### Raphael Megali @ramegali
will write the code necessary to get the relevant weather information extracted.

### Rob Cucchiara @rcucchiara
will take the retrieved weather data and present it in an appealing and compelling way.
