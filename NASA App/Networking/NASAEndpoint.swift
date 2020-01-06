//
//  NASAEndpoint.swift
//  NASA App
//
//  Created by Arwin Oblea on 1/3/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import Foundation

enum NASAEndpoint {
// put cases here
  case marsPhotos(key: String)
  
}

extension NASAEndpoint: Endpoint {
  var base: String {
    switch self {
    case .marsPhotos:
      return "https://api.nasa.gov"
    }
  }
  
  var path: String {
    switch self {
    case .marsPhotos:
      return "/mars-photos/api/v1/rovers/curiosity/photos"
    }
  }
  
  // sol value is defaulted 
  var queryItems: [URLQueryItem] {
    switch self {
    case .marsPhotos(let key):
      return [
      URLQueryItem(name: "sol", value: "1000"),
      URLQueryItem(name: "api_key", value: key.description)
      ]
    }
  }
  
  
}

// For Rover on Mars
//https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=xCieywUphIaacqI9FG4hkAtpdTClyiyE3lIO9a6F
