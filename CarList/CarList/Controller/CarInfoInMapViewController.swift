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
  private let restClient = RestClient()

  // MARK : - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    centerMapOnLocation(location: Constants.InitialLocation)
    requestCarInformation()
  }

  // MARK : - Set Center Coordinates
  private func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion
      = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                          Constants.RegionRadius * 2.0,
                                          Constants.RegionRadius * 2.0)
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
      print(carInfoList)
      DispatchQueue.main.async {
        self.mapView.addAnnotations(carInfoList)
      }
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
      mapView.dequeueReusableAnnotationView(withIdentifier: Constants.MapViewPinID) as? MKPinAnnotationView else {
      view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.MapViewPinID)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      return view
    }

    dequeuedView.annotation = annotation
    view = dequeuedView
    return view
  }
}
