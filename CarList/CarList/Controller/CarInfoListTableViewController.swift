//
//  CarInfoListTableViewController.swift
//  CarList
//
//  Created by siwook on 2017. 10. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK: - CarInfoListTableViewController: UITableViewController
class CarInfoListTableViewController: UITableViewController {

  // MARK: - Property List
  var carInfoList: [CarInfo]!

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: - Target Action
  @IBAction func tapCloseButton(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
}

// MARK: - CarInfoListTableViewController
extension CarInfoListTableViewController {

  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return carInfoList.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.CarInfoList,
                                                   for: indexPath) as? CarInfoListTableViewCell else {
      fatalError(Constants.FatalError.UnexpectedCarInfoTableCell)
    }
    cell.carInfo = carInfoList[indexPath.row]
    return cell
  }
}
