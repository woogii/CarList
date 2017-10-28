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

  // MARK: - Map Information
  struct MapInfo {
    static let RegionRadius: CLLocationDistance = 2000
    static let InitialLocation                  = CLLocation(latitude: 48.163106, longitude: 11.564346)
    static let AnnotationCallOutOffset          = CGPoint(x: -5, y: 5)
    static let PinID                            = "pin"
  }

  // MARK: - Car Information Description Prefix
  struct CarInfoDescPrefix {
    static let CarID            = "Id : "
    static let ModelID          = "ModelId: "
    static let ModelName        = "Model Name: "
    static let Name             = "Name: "
    static let Make             = "Make : "
    static let Group            = "Group: "
    static let Color            = "Color: "
    static let Series           = "Series: "
    static let FuelType         = "FuelType : "
    static let FuelLevel        = "FuelLevel: "
    static let Transmission     = "Transmission: "
    static let LicensePlate     = "LicensePlate : "
    static let Latitude         = "Latitude : "
    static let Longitude        = "Longitude : "
    static let InnerClenliness  = "InnerClenliness: "
    static let ImageUrl         = "ImageUrl : "
  }

  // MARK: - Fatal Error
  struct FatalError {
    static let UnexpectedCarInfoTableCell = "Unexpected TableViewCell"
  }

  static let ListButtonCornerRadius: CGFloat = 5.0
  static let ListButtonShadowOpacity: Float  = 0.3
  static let PlaceHolderImageName            = "ic_default_car"

  static let FuelLevelPrefix      = "Fuel level "
  static let FuelLevelUnit        = "%"
  static let DistanceKmFormat     = "%0.1f km"
  static let DistanceMeterFormat  = "%0.1f m"
  static let NameLabelPrefix      = "Hi, I am "
  static let NameLabelSuffix      = "."

  static let CarInfoViewBottomConstraint: CGFloat = -150

  // MARK: - Segue ID
  struct SegueID {
    static let ShowCarInfoList = "showCarInfoList"
  }
  // MARK: - Cell ID
  struct CellID {
    static let CarInfoList = "carInfoListTableViewCell"
  }

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
