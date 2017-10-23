//
//  RestClient.swift
//  CarList
//
//  Created by siwook on 2017. 10. 23..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK: - RestClient
struct RestClient {

  // MARK: - Type Alias List
  typealias RequestResult = (_ result: [CarInfo]?, _ error: Error?) -> Void

  // MARK: - URLSession Task For Resource
  func taskForResource(with url: URL, completionHanlder: @escaping RequestResult) {
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completionHanlder(nil, error)
      } else {
        guard let data = data, let httpResponse = response as? HTTPURLResponse,
          200..<300 ~= httpResponse.statusCode else {
            return
        }
        var carInfoList = [CarInfo]()
        do {
          guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
            return
          }
          print(json)
          carInfoList = json.flatMap {
            do {
              return try CarInfo(dictionary: $0)
            } catch {
              return nil
            }
          }
        } catch let error as NSError {
          print(error.localizedDescription)
        }
        completionHanlder(carInfoList, nil)
      }
    }.resume()
  }
}
