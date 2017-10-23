//
//  CarInfo.swift
//  CarList
//
//  Created by siwook on 2017. 10. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation
import MapKit

// MARK : - SerializaionError : Error
enum SerializaionError: Error {
  case missing(String)
  case invalid(String, Any)
}

// MARK: - CarInfo: NSObject, MKAnnotation
class CarInfo: NSObject, MKAnnotation {

  // MARK: - Property List
  let idKey: String
  let modelIdentifier: String
  let modelName: String
  let name: String
  let make: String
  let group: String
  let color: String
  let series: String
  let fuelType: String
  let fuelLevel: Float
  let transmission: String
  let licensePlate: String
  let longitude: CLLocationDegrees
  let latitude: CLLocationDegrees
  let innerCleanliness: String
  let imageUrl: String
  var title: String? {
    return make + modelName
  }
  var subtitle: String? {
    return licensePlate
  }
  var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(latitude, longitude)
  }
  // MARK: - Initialization
  // swiftlint:disable:next cyclomatic_complexity function_body_length
  init(dictionary: [String:Any]) throws {
    guard let id = dictionary[Constants.API.JSONParsingKeys.IdKey] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.IdMissing)
    }
    guard let modelId = dictionary[Constants.API.JSONParsingKeys.ModelId] as? String else {
        throw SerializaionError.missing(Constants.SerializaionErrorDesc.ModelIdMissing)
    }
    guard let modelName = dictionary[Constants.API.JSONParsingKeys.ModelName] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.ModelNameMissing)
    }
    guard let name = dictionary[Constants.API.JSONParsingKeys.Name] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.NameMissing)
    }
    guard let make = dictionary[Constants.API.JSONParsingKeys.Make] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.MakeMissing)
    }
    guard let group = dictionary[Constants.API.JSONParsingKeys.Group] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.GroupMissing)
    }
    guard let color = dictionary[Constants.API.JSONParsingKeys.Color] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.ColorMissing)
    }
    guard let series = dictionary[Constants.API.JSONParsingKeys.Series] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.SeriesMissing)
    }
    guard let fuelType = dictionary[Constants.API.JSONParsingKeys.FuelType] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.FuelTypeMissing)
    }
    guard let fuelLevel = dictionary[Constants.API.JSONParsingKeys.FuelLevel] as? Float else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.FuelLevelMissing)
    }
    guard let latitude = dictionary[Constants.API.JSONParsingKeys.Latitude] as? CLLocationDegrees else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.LatitudeMissing)
    }
    guard case (-90.0...90.0) = latitude else {
      throw SerializaionError.invalid(Constants.SerializaionErrorDesc.LatitudeInvalid, latitude)
    }
    guard let longitude = dictionary[Constants.API.JSONParsingKeys.Longitude] as? CLLocationDegrees else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.LongitudeMissing)
    }
    guard case (-180.0...180.0) = longitude else {
      throw SerializaionError.invalid(Constants.SerializaionErrorDesc.LongitudeInvalid, longitude)
    }
    guard let transmission = dictionary[Constants.API.JSONParsingKeys.Transmission] as?  String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.TransmissionMissing)
    }
    guard let licensePlate = dictionary[Constants.API.JSONParsingKeys.LicensePlate] as?  String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.LicensePlateMissing)
    }
    guard let innerCleanliness = dictionary[Constants.API.JSONParsingKeys.InnerCleanliness] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.InnerCleanlinessMissing)
    }
    guard let carImageUrl = dictionary[Constants.API.JSONParsingKeys.CarImageUrl] as? String else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.CarImageUrlMissing)
    }
    self.idKey = id
    self.modelIdentifier = modelId
    self.modelName = modelName
    self.name = name
    self.make = make
    self.group = group
    self.color = color
    self.series = series
    self.fuelType = fuelType
    self.fuelLevel = fuelLevel
    self.transmission = transmission
    self.licensePlate = licensePlate
    self.latitude = latitude
    self.longitude = longitude
    self.innerCleanliness = innerCleanliness
    self.imageUrl = carImageUrl
  }
}

extension CarInfo {
  override var description: String {
    let carInfo = Constants.CarInfoDescPrefix.CarID           + "\(self.idKey), "            +
                  Constants.CarInfoDescPrefix.ModelID         + "\(self.modelIdentifier), "  +
                  Constants.CarInfoDescPrefix.ModelName       + "\(self.modelName), "        +
                  Constants.CarInfoDescPrefix.Name            + "\(self.name), "             +
                  Constants.CarInfoDescPrefix.Make            + "\(self.make), "             +
                  Constants.CarInfoDescPrefix.Group           + "\(self.group), "            +
                  Constants.CarInfoDescPrefix.Color           + "\(self.color), "            +
                  Constants.CarInfoDescPrefix.Series          + "\(self.series), "           +
                  Constants.CarInfoDescPrefix.FuelType        + "\(self.fuelType), "         +
                  Constants.CarInfoDescPrefix.FuelLevel       + "\(self.fuelLevel), "        +
                  Constants.CarInfoDescPrefix.Transmission    + "\(self.transmission), "     +
                  Constants.CarInfoDescPrefix.LicensePlate    + "\(self.licensePlate), "     +
                  Constants.CarInfoDescPrefix.Latitude        + "\(self.latitude), "         +
                  Constants.CarInfoDescPrefix.Longitude       + "\(self.longitude), "        +
                  Constants.CarInfoDescPrefix.InnerClenliness + "\(self.innerCleanliness), " +
                  Constants.CarInfoDescPrefix.ImageUrl        + "\(self.imageUrl)\n"
    return carInfo
  }
}
