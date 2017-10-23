//
//  ViewController.swift
//  CarList
//
//  Created by siwook on 2017. 10. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage

// MARK: - CarInfoInMapViewController: UIViewController
class CarInfoInMapViewController: UIViewController {

  // MARK : - Property List
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var listButton: UIButton!
  @IBOutlet weak var carImageView: UIImageView!
  @IBOutlet weak var carInfoViewBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var carInfoView: UIView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var licensePlateLabel: UILabel!
  @IBOutlet weak var manufacturerLabel: UILabel!
  @IBOutlet weak var modelNameLabel: UILabel!
  @IBOutlet weak var fuelLevelLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  private let restClient = RestClient()
  private var carInfoList = [CarInfo]()

  // MARK : - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    centerMapOnLocation(location: Constants.MapInfo.InitialLocation)
    addListButtonShadow()
    requestCarInformation()
  }

  // MARK : - Add Button Shadow
  private func addListButtonShadow() {
    listButton.layer.cornerRadius  = Constants.ListButtonCornerRadius
    listButton.layer.shadowColor   = UIColor.black.cgColor
    listButton.layer.shadowOffset  = CGSize.zero
    listButton.layer.shadowOpacity = Constants.ListButtonShadowOpacity
    listButton.layer.shadowPath    = UIBezierPath(rect: listButton.bounds).cgPath
  }
  // MARK : - Set Center Coordinates
  private func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion
      = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                          Constants.MapInfo.RegionRadius * 2.0,
                                          Constants.MapInfo.RegionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
  }

  // MARK : - Request Car Information
  private func requestCarInformation() {
    guard let url = URL(string: Constants.API.BaseURL) else { return }
    restClient.taskForResource(with: url) { (carInfoList, error) in
      guard error == nil else {
        print(error!.localizedDescription)
        return
      }
      guard let carInfoList = carInfoList else {
        return
      }
      self.carInfoList = carInfoList
      DispatchQueue.main.async {
        self.mapView.addAnnotations(carInfoList)
      }
    }
  }
  // MARK : - Prepare for Segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Constants.SegueID.ShowCarInfoList {
      guard let destinationNavVC = segue.destination as? UINavigationController else {
        return
      }
      guard let destinationVC = destinationNavVC.topViewController as? CarInfoListTableViewController else {
        return
      }
      destinationVC.carInfoList = carInfoList
    }
  }
}

// MARK: - CarInfoInMapViewController : MKMapViewDelegate
extension CarInfoInMapViewController: MKMapViewDelegate {

  // MARK: - MKMapViewDelegate Method
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let annotation = annotation as? CarInfo else {
      return nil
    }

    var view: MKPinAnnotationView

    guard let dequeuedView =
      mapView.dequeueReusableAnnotationView(withIdentifier: Constants.MapInfo.PinID) as? MKPinAnnotationView else {
      view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.MapInfo.PinID)
      view.canShowCallout = true
      view.calloutOffset = Constants.MapInfo.AnnotationCallOutOffset
      return view
    }

    dequeuedView.annotation = annotation
    view = dequeuedView
    return view
  }
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

    UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions(), animations: {

      self.carInfoViewBottomConstraint.constant = 0
      self.view.layoutIfNeeded()
      self.displayCardInfo(selectedAnnotation: view)

    }, completion: nil)

  }

  private func displayCardInfo(selectedAnnotation: MKAnnotationView) {
    guard let carInfo = selectedAnnotation.annotation as? CarInfo else { return }
    setNameLabel(carInfo: carInfo)
    setModelNameLabel(carInfo: carInfo)
    setCarImageView(carInfo: carInfo)
    setLicensePlateLabel(carInfo: carInfo)
    setManufacturerLabel(carInfo: carInfo)
    setModelNameLabel(carInfo: carInfo)
    setFuelLevelLabel(carInfo: carInfo)
    setDistanceLabel(carInfo: carInfo)
  }

  private func setNameLabel(carInfo: CarInfo) {
    nameLabel.text = Constants.NameLabelPrefix + carInfo.name + Constants.NameLabelSuffix
  }

  private func setCarImageView(carInfo: CarInfo) {

    let imageUrlString = Constants.API.BaseImageURL + "/"  + carInfo.modelIdentifier
      + "/" + carInfo.color + Constants.API.BaseImageURLSuffix

    let imageUrl = URL(string: imageUrlString)!

    // Fetch Image from Memory Cache
    if let image = SDImageCache.shared().imageFromMemoryCache(forKey: imageUrl.absoluteString) {
      self.carImageView.image = image
    } else {
      self.carImageView
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
  // MARK: - Set Car License Info
  private func setLicensePlateLabel(carInfo: CarInfo) {
    licensePlateLabel.text = carInfo.licensePlate
  }
  // MARK: - Set Car Manufacturer Info
  private func setManufacturerLabel(carInfo: CarInfo) {
    manufacturerLabel.text = carInfo.make
  }
  // MARK: - Set Car Model Name Info
  private func setModelNameLabel(carInfo: CarInfo) {
    modelNameLabel.text = carInfo.modelName
  }
  // MARK: - Set Car Fuel Level Info
  private func setFuelLevelLabel(carInfo: CarInfo) {
    fuelLevelLabel.text = Constants.FuelLevelPrefix + "\(carInfo.fuelLevel * 100.0)" + Constants.FuelLevelUnit
  }
  // MARK: - Set Car Distance Info
  private func setDistanceLabel(carInfo: CarInfo) {
    let destLocation = CLLocation(latitude: carInfo.latitude, longitude: carInfo.longitude)
    var distanceInMeters = Constants.MapInfo.InitialLocation.distance(from: destLocation)
    if distanceInMeters > 1000 {
      distanceInMeters /= 1000
      distanceLabel.text = String(format: Constants.DistanceKmFormat, distanceInMeters)
    } else {
      distanceLabel.text = String(format: Constants.DistanceMeterFormat, distanceInMeters)
    }
  }

  func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {

    UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions(), animations: {
      self.carInfoViewBottomConstraint.constant = Constants.CarInfoViewBottomConstraint
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
}
