//
//  ViewController.swift
//  CarList
//
//  Created by siwook on 2017. 10. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import MapKit

// MARK: - CarInfoInMapViewController: UIViewController
class CarInfoInMapViewController: UIViewController {

  // MARK : - Property List
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var listButton: UIButton!
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
}
