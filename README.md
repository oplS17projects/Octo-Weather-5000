# Octo-Weather-5000

### Statement
Describe your project. Why is it interesting? Why is it interesting to you personally? What do you hope to learn? 

Project revolves around implementing a program that will not only give you relevant time and date information, but weather forecast as well in a practical and useful way. We hope to learn more about APIs, information parsing, and web development in general, and that's why this project is interesting on a personal level.

### Analysis
Explain what approaches from class you will bring to bear on the project.

Be explicit about the techiques from the class that you will use. For example:

- Will you use data abstraction? How?
- Will you use recursion? How?
- Will you use map/filter/reduce? How? 
- Will you use object-orientation? How?
- Will you use functional approaches to processing your data? How?
- Will you use state-modification approaches? How? (If so, this should be encapsulated within objects. `set!` pretty much should only exist inside an object.)
- Will you build an expression evaluator, like we did in the symbolic differentatior and the metacircular evaluator?
- Will you use lazy evaluation approaches?

The idea here is to identify what ideas from the class you will use in carrying out your project. 

**Your project will be graded, in part, by the extent to which you adopt approaches from the course into your implementation, _and_ your discussion about this.**

- DATA ABSTRACTION: getting weather from websites/APIs 
- OOP/state-modification: A possiblility? Create a weather object and time object and have them do everything.
- RECURSION: I'm thinking of using recursion to display weather data taken from a list. I'm sure there are other things.


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

We also plan on using Google's Geolocation API once we figure out how to implement it. This will allow the webpage to get the user's location info, and then we use that to get the weather from our other API.


### Deliverable and Demonstration
Explain exactly what you'll have at the end. What will it be able to do at the live demo?

What exactly will you produce at the end of the project? A piece of software, yes, but what will it do? Here are some questions to think about (and answer depending on your application).

Will it run on some data, like batch mode? Will you present some analytical results of the processing? How can it be re-run on different source data?

Will it be interactive? Can you show it working? This project involves a live demo, so interactivity is good.

PLAN: Have a webpage that will deliver date, time, current weather, and forecast. As for interactions, maybe have charts/graphs that are interactive, as well as being able to switch from five day forecast to detailed single day forecast. 

**In the end, we'll have a program that will display time and weather. Users can interact with it to see charts/graphs, as well as detailed hourly forecasts versus five day forecasts.**

### Evaluation of Results
How will you know if you are successful? 
If you include some kind of _quantitative analysis,_ that would be good.

- If the weather and time can be gathered accurately depending on user's location.
- If users can interact with it without having it break.

## Architecture Diagram
Upload the architecture diagram you made for your slide presentation to your repository, and include it in-line here.

Create several paragraphs of narrative to explain the pieces and how they interoperate.

## Schedule
Explain how you will go from proposal to finished product. 

### First Milestone (Sun Apr 9)
- Know exactly what APIs we will be using, as well as have all the tools to parse the info.
- 

### Second Milestone (Sun Apr 16)
- 

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])
- 

## Group Responsibilities
Here each group member gets a section where they, as an individual, detail what they are responsible for in this project. Each group member writes their own Responsibility section. Include the milestones and final deliverable.

(Please use Github properly: each individual must make the edits to this file representing their own section of work)

### Raphael Megali @ramegali
will write the code necessary to get the relevant weather information extracted.

### Rob Cucchiara @rcucchiara
will take the retrieved weather data and present it in an appealing and compelling way.
