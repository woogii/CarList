//
//  ViewController.swift
//  CarList
//
//  Created by siwook on 2017. 10. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK: - CarInfoInMapViewController: UIViewController
class CarInfoInMapViewController: UIViewController {

  let restClient = RestClient()

  // MARK : - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    requestCarInformation()
  }

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
    }
  }
}
