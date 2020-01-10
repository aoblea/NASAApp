//
//  NASAClient.swift
//  NASA App
//
//  Created by Arwin Oblea on 1/3/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import Foundation
import UIKit

class NASAClient: APIClient {
  var session: URLSession
  var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    return decoder
  }()
  
  // API Key required for url request, set to private because this is the only place that it will be used.
  private let apiKey: String = "xCieywUphIaacqI9FG4hkAtpdTClyiyE3lIO9a6F"
  
  init(configuration: URLSessionConfiguration) {
    self.session = URLSession(configuration: configuration)
  }
  
  convenience init() {
    self.init(configuration: .default)
  }
  
  func getMarsPhotos(completion: @escaping (Result<MarsPhotos, APIError>) -> Void) {
    let endpoint = NASAEndpoint.marsPhotos(key: apiKey)
    let request = endpoint.request

    fetch(with: request, completion: completion)
  }

  func getEarthImagery(latitude: String, longitude: String, completion: @escaping (Result<EarthImagery, APIError>) -> Void) {
    let endpoint = NASAEndpoint.earthImagery(lat: latitude, lon: longitude, key: apiKey)
    let request = endpoint.request
  
    fetch(with: request, completion: completion)
  }

}

