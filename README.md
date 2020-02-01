# NASA App
## Treehouse iOS Project 10

The NASA App is an iOS app in swift that uses the NASA API.

This project contains the use of:
  * UICollectionViews
  * ScrollViews
  * Animation
  * Unit Testing
  * Error Handling
  * Asynchronous Networking

### Project Instructions

  1. The app must have a landing screen and 2 main areas, one for each of the functionalities described below.
  
  2. Rover Postcard Maker: Access the Mars Rover Imagery API and display a selected, filtered, or randomized image from the Mars Rover. You should also build functionalities such that a user can add text over the image and then flatten the new image and send through a prepopulated email address (you may hard-code the email address). Please clearly indicate in a comment where this email address is in the code, such that the reviewer can alter it for testing.
  
  3. Eye-In-the-Sky: Build a tool to access the Earth Imagery API. Users should be able to, at a minimum, query the most recent photo of a particular location on earth. You can also let the user search for an address, get the location information based on an interactive map, import addresses from contacts, or even another API (such as Foursquare).
  
  4. The app MUST make use of UICollectionViews, ScrollViews, Animation, Unit Testing, and Error Handling.
  
  5. In your implementation, be sure to utilize asynchronous networking code and where possible, make your code reusable for the different items you'll be displaying.
  
  6. Ensure that you implement Unit Testing to test the code which downloads and parses the data from the API. In addition, test any edge cases, such as not receiving latitude and longitude data.
  
  7. If you use any third party libraries, please also include details in a readme.md file on how to install, configure, and load the third party libraries such that the project reviewer can configure it on their machine.
  
  8. Ensure that your app performs well. You should test all functionalities in Xcode Instruments and describe what performance testing you did in a code comment in the AppDelegate.swift file
  
  9. Since this is the capstone project, you will be graded on the following:
      * Good Object Oriented Design and Implementation (e.g. proper usage of classes, structs, composition, inheritance, protocols, and extensions)
      * Efficient API consumption (e.g. Are asynchronous networking calls being used?)
      * UI layout is clean and professional and user workflow is intuitive; App icon is setup properly
      * Error handling is robust
      * Sufficient Unit Testing is included
      * App performance is good (e.g. User does not need to wait more than a couple of seconds for each action)
      * Code is organized with useful comments
      
### Extra Credit

  * Create your own custom feature! In order to get an overall "Exceeds" grade for this project, you must implement an additional module. Leverage skills learned in the Techdegree and the NASA API in a meaningful way, plus at least one skill, API, or language feature NOT explicitly covered in the course thus far. Remember to create an additional main area as well for this function. Please provide detailed comment and usage instruction such that the functionality can be reviewed properly, and again, details about any third party libraries that you use.

Used Kingfisher dependency for this project.

Installation Guide: https://github.com/onevcat/Kingfisher/wiki/Installation-Guide

1. Select File > Swift Packages > Add Package Dependency. Enter https://github.com/onevcat/Kingfisher.git in the "Choose Package Repository" dialog.
2. In the next page, specify the version resolving rule as "Up to Next Major" with "5.8.0" as its earliest version.
3. After Xcode checking out the source and resolving the version, you can choose the "Kingfisher" library and add it to your app target.
