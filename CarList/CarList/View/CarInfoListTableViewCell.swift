//
//  CarInfoListTableViewCell.swift
//  CarList
//
//  Created by siwook on 2017. 10. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import SDWebImage
import CoreLocation

// MARK: - CarInfoListTableViewCell: UITableViewCell
class CarInfoListTableViewCell: UITableViewCell {

  // MARK: - Property List
  @IBOutlet weak var carImageView: UIImageView!
  @IBOutlet weak var licensePlateLabel: UILabel!
  @IBOutlet weak var manufacturerLabel: UILabel!
  @IBOutlet weak var modelNameLabel: UILabel!
  @IBOutlet weak var fuelLevelLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!

  var carInfo: CarInfo! {
    didSet {
      updateUI()
    }
  }

  // MARK: - Prepare For Reusing Cell
  override func prepareForReuse() {
    super.prepareForReuse()
    carImageView.sd_cancelCurrentImageLoad()
  }

  // MARK: - Update Cell UI
  private func updateUI() {
    setCarImageView()
    setLicensePlateLabel()
    setManufacturerLabel()
    setModelNameLabel()
    setFuelLevelLabel()
    setDistanceLabel()
  }

  // MARK: - Set Car Image Info
  private func setCarImageView() {

    guard let imageUrl = constructCarImageUrl() else { return }

    // Initialize carImageView
    carImageView.image = nil
    // Fetch Image from Memory Cache
    if let image = SDImageCache.shared().imageFromMemoryCache(forKey: imageUrl.absoluteString) {
      self.carImageView.image = image
    } else {
      carImageView
        .sd_setImage(with: imageUrl, placeholderImage: UIImage(named: Constants.PlaceHolderImageName),
                     options: SDWebImageOptions()) { (image, error, _, _) in
                      if image != nil {
                        DispatchQueue.main.async {
                          self.carImageView.image = image
                        }
                      } else {
                        print(error?.localizedDescription as Any)
                      }
      }
    }
  }

  // MARK: - Construct Image Url
  private func constructCarImageUrl() -> URL? {
    let imageUrlString = Constants.API.BaseImageURL + "/"  + carInfo.modelIdentifier
                         + "/" + carInfo.color + Constants.API.BaseImageURLSuffix

    let imageUrl = URL(string: imageUrlString)
    return imageUrl
  }

  // MARK: - Set Car License Info
  private func setLicensePlateLabel() {
    licensePlateLabel.text = carInfo.licensePlate
  }
  // MARK: - Set Car Manufacturer Info
  private func setManufacturerLabel() {
    manufacturerLabel.text = carInfo.make
  }
  // MARK: - Set Car Model Name Info
  private func setModelNameLabel() {
    modelNameLabel.text = carInfo.modelName
  }
  // MARK: - Set Car Fuel Level Info
  private func setFuelLevelLabel() {
    fuelLevelLabel.text = Constants.FuelLevelPrefix + "\(carInfo.fuelLevel * 100.0)" + Constants.FuelLevelUnit
  }
  // MARK: - Set Car Distance Info
  private func setDistanceLabel() {
    let destLocation = CLLocation(latitude: carInfo.latitude, longitude: carInfo.longitude)
    var distanceInMeters = Constants.MapInfo.InitialLocation.distance(from: destLocation)
    if distanceInMeters > 1000 {
      distanceInMeters /= 1000
      distanceLabel.text = String(format: Constants.DistanceKmFormat, distanceInMeters)
    } else {
      distanceLabel.text = String(format: Constants.DistanceMeterFormat, distanceInMeters)
    }
  }
}
