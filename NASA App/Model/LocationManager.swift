//
//  LocationManager.swift
//  NASA App
//
//  Created by Arwin Oblea on 1/9/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import UIKit
import CoreLocation

/// Manager for requesting authorization in order for core location to be enabled.
class LocationManager: NSObject {
  // MARK: - Properties
  
  static let sharedInstance = LocationManager()
  private let manager = CLLocationManager()
  
  // Checks authorization status. If the status was not determined or was denied, it will request authorization else nothing happens
  func requestLocationAuthorization() {
    switch CLLocationManager.authorizationStatus() {
    case .denied, .notDetermined:
      manager.requestWhenInUseAuthorization()
    case .authorizedAlways, .authorizedWhenInUse, .restricted:
      return
    default:
      return
    }
  }
  
}
