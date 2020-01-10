//
//  EarthImagery.swift
//  NASA App
//
//  Created by Arwin Oblea on 1/9/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import Foundation
import UIKit

struct EarthImagery: Decodable {
  let id: String
  let date: String
  let imageURLString: String
  
  var image: UIImage?
  
  private enum EarthImageryCodingKeys: String, CodingKey {
    case id
    case date
    case url
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: EarthImageryCodingKeys.self)
    self.id = try container.decode(String.self, forKey: .id)
    self.date = try container.decode(String.self, forKey: .date)
    self.imageURLString = try container.decode(String.self, forKey: .url)
  }
}
