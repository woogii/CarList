//
//  Constants.swift
//  CarList
//
//  Created by siwook on 2017. 10. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK: - Constants
struct Constants {

  // MARK: - API
  struct API {

    static let BaseURL = "http://www.codetalk.de/cars.json"

    // MARK: - URL Query List
    struct QueryItem {
      static let FormatKey           = "format"
      static let FormatValue         = "xml"
      static let ResultsPerPageKey   = "results_per_page"
      static let ResultsPerPageValue = "20"
      static let SubIdKey            = "sub_id"
      static let SubIdValue          = "siwook"
      static let ActionKey           = "action"
      static let ActionValue         = "remove"
      static let APIKey              = "api_key"
      static let APIValue            = "MTkxNzY4"
      static let ImageIdKey          = "image_id"
      static let SizeKey             = "size"
      static let SizeValue           = "small"
    }

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
