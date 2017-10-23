# CarList


This is a simple demo application that shows car information, both on a map and a list. If users launch the application, they can see the pins on the map that locates the car. If they tap the pin, a message bubble with the car manufacturer and model name will show up. In addition, there is a button on the upper-right side of the screen. If the button is pushed, the app moves to the next screen and shows a list of car information.


## Tasks
* Query Car Information from [JSON](http://www.codetalk.de/cars.json)
* Display Car Information both in a `MKMapView` and in a `UITableView`

## How to solve 

* Populate car information on a custom `MKMapView` via `MKMapViewDelegate` Method.
* Use a open source library([SDWebImage](https://github.com/rs/SDWebImage)) to download car images asynchronously
* Car images are cached automatically since [SDWebImage](https://github.com/rs/SDWebImage) provides a built-in cache mechanism
* Populate car information on a custom `UITableViewCell` via `UITableViewDataSource` Methods.


## Design decision 

This application follows the MVC (Model-View-Controller) pattern. 

* **Model** Layer - *__CarInfo__* class is a subclass of `MKAnnotation` and is defined with Initializer and member variables. It stores information related to the car such as a car image URL, a model name, a location, and so on during the initialization process.

* **Controller** Layer -  *__CarInfoInMapViewController__* displays the locations of cars on the `MKMapView`. It holds *__CarInfo__* array and the values of the array are assigned after car information is downloaded via the web. As aforementioned, *__CarInfo__* is the subclass of `MKAnnotation` and it is used as a data source of `MKMapView` to display `MKPinAnnotationView` on the map. *__CarInfoListTableViewController__* is a subclass of `UITableViewController` and holds a *__carInfo__* type array which was passed from the *__CarInfoInMapViewController__*. The controller populates car information on the tableView via `UITableViewDataSource` Methods.

 
* **View** Layer - *__CarInfoListTableViewCell__* is responsible for displaying car information including images. The cell has a property observer of *__CarInfo__* type which triggers the cell's UI updates when a property is assigned a new value in the Controller layer.


# Open Source Licence

*  [SDWebImage](https://github.com/rs/SDWebImage)
*  [SwiftLint](https://github.com/realm/SwiftLint)

## Image Licence 

* [Icons8](https://icons8.com/) 

# How to build 

1) Clone the repository 

```
$ git clone https://github.com/woogii/CarList.git
$ cd CarList
```
2) Install SwiftLint

```
$ brew install swiftlint
```
3) Set up the third party library 

```
$ pod install
```

4) Open the workspace in XCode 

```
$ open CarList.xcworkspace/
```

5) Compile and run the app in your simulator or iPhone 

# Compatibility 
The code of this project works in Swift3.0, Xcode 8.3.1 and iOS9 