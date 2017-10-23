//
//  Constants.swift
//  CarList
//
//  Created by siwook on 2017. 10. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

// MARK: - Constants
struct Constants {

  static let RegionRadius: CLLocationDistance = 1000
  static let InitialLocation                  = CLLocation(latitude: 48.163106, longitude: 11.564346)
  static let AnnotationCallOutOffset          = CGPoint(x: -5, y: 5)
  static let MapViewPinID                     = "pin"

  static let IdDescPrefix              = "Id : "
  static let ModelIDDescPrefix         = "ModelId: "
  static let ModelNameDescPrefix       = "Model Name: "
  static let NameDescPrefix            = "Name: "
  static let MakeDescPrefix            = "Make : "
  static let GroupDescPrefix           = "Group: "
  static let ColorPrefix               = "Color: "
  static let SeriesDescPrefix          = "Series: "
  static let FuelTypeDescPrefix        = "FuelType : "
  static let FuelLevelDescPrefix       = "FuelLevel: "
  static let TransmissionDescPrefix    = "Transmission: "
  static let LicensePlateDescPrefix    = "LicensePlate : "
  static let LatitudeDescPrefix        = "Latitude : "
  static let LongitudeDescPrefix       = "Longitude : "
  static let InnerClenlinessDescPrefix = "InnerClenliness: "
  static let ImageUrlDescPrefix        = "ImageUrl : "

  // MARK: - API
  struct API {

    static let BaseURL = "http://www.codetalk.de/cars.json"
    static let BaseImageURL = "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/"
    static let BaseImageURLSuffix = "/2x/car.png"

    // MARK: - JSON Parsing Key List
    struct JSONParsingKeys {
      static let IdKey            = "id"
      static let ModelId          = "modelIdentifier"
      static let ModelName        = "modelName"
      static let Name             = "name"
      static let Make             = "make"
      static let Group            = "group"
      static let Color            = "color"
      static let Series           = "series"
      static let FuelType         = "fuelType"
      static let FuelLevel        = "fuelLevel"
      static let Transmission     = "transmission"
      static let LicensePlate     = "licensePlate"
      static let Latitude         = "latitude"
      static let Longitude        = "longitude"
      static let InnerCleanliness = "innerCleanliness"
      static let CarImageUrl      = "carImageUrl"
    }
  }

  // MARK: - Serializaion Error Description
  struct SerializaionErrorDesc {
    // MARK : - Error Messages
    static let IdMissing               = "ID is missing"
    static let ModelIdMissing          = "Model ID is missing"
    static let ModelNameMissing        = "Model Name is missing"
    static let NameMissing             = "Name is missing"
    static let MakeMissing             = "Make is missing"
    static let GroupMissing            = "Group is missing"
    static let ColorMissing            = "Color is missing"
    static let SeriesMissing           = "Series is missing"
    static let FuelTypeMissing         = "Fuel Type is missing"
    static let FuelLevelMissing        = "Fuel Level is missing"
    static let TransmissionMissing     = "Transmission is missing"
    static let LicensePlateMissing     = "License Plate is missing"
    static let LatitudeMissing         = "Latitude is missing"
    static let LongitudeMissing        = "Longitude is missing"
    static let InnerCleanlinessMissing = "Inner Cleanliness is missing"
    static let CarImageUrlMissing      = "Car Image URL is missing"
    // MARK : - Invalid Messages
    static let LatitudeInvalid         = "The value of Latitude average is not valid"
    static let LongitudeInvalid        = "The value of Longitude average is not valid"
  }

}
