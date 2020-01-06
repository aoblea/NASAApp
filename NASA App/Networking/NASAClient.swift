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
//  print(request)
//  resulting request string
//  https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=xCieywUphIaacqI9FG4hkAtpdTClyiyE3lIO9a6F
    fetch(with: request, completion: completion)
  }
  
  func getImageData(with photo: Photo, completion: @escaping (Result<Data, APIError>) -> Void) {
    let source = photo.imageSource
    guard let url = URL(string: source) else { return }
    let request = URLRequest(url: url)
    print(request)
    fetch(with: request, completion: completion)
  }

}

