//
//  NASAEndpoint.swift
//  NASA App
//
//  Created by Arwin Oblea on 1/3/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import Foundation

enum NASAEndpoint {
  case marsPhotos(key: String)
  case earthImagery(lat: String, lon: String, key: String)
}

extension NASAEndpoint: Endpoint {
  var base: String {
    switch self {
    case .marsPhotos, .earthImagery:
      return "https://api.nasa.gov"
    }
  }
  
  var path: String {
    switch self {
    case .marsPhotos:
      return "/mars-photos/api/v1/rovers/curiosity/photos"
    case .earthImagery:
      return "/planetary/earth/imagery/"
    }
  }
  
  var queryItems: [URLQueryItem] {
    switch self {
    case .marsPhotos(let key):
      return [
      URLQueryItem(name: "sol", value: "1000"), // sol value is defaulted
      URLQueryItem(name: "api_key", value: key.description)
      ]
    case .earthImagery(let lat, let lon, let key):
      return [
        URLQueryItem(name: "lat", value: lat.description),
        URLQueryItem(name: "lon", value: lon.description),
        URLQueryItem(name: "api_key", value: key.description)
      ]
    }
  }
    
}


// For Rover on Mars
//https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=xCieywUphIaacqI9FG4hkAtpdTClyiyE3lIO9a6F

// For Earth Imagery
//https://api.nasa.gov/planetary/earth/imagery/?lon=100.75&lat=1.5&date=2014-02-01&cloud_score=True&api_key=xCieywUphIaacqI9FG4hkAtpdTClyiyE3lIO9a6F
