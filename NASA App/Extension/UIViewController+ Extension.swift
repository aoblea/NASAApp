//
//  UIViewController+ Extension.swift
//  NASA App
//
//  Created by Arwin Oblea on 1/9/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import UIKit

extension UIViewController {
  func presentAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alert = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alertController.addAction(alert)
    
    self.present(alertController, animated: true)
  }
}
