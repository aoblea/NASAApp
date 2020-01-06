//
//  MarsPhotos.swift
//  NASA App
//
//  Created by Arwin Oblea on 1/3/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import UIKit

//
struct MarsPhotos: Decodable {
  let photos: [Photo]
  
  private enum MarsPhotosCodingKeys: String, CodingKey {
    case photos
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: MarsPhotosCodingKeys.self)
    self.photos = try container.decode([Photo].self, forKey: .photos)
  }
}

struct Photo: Decodable {
  let id: Int
  let sol: Int
  let imageSource: String
  let earthDate: String
  
  // Image Setup
  enum ImageDownloadState {
    case placeholder, downloaded, failed
  }
  
  var image: UIImage? = nil
  var imageState: ImageDownloadState = .placeholder

  private enum PhotosCodingKeys: String, CodingKey {
    case id
    case sol
    case imgsrc = "img_src"
    case earthdate = "earth_date"
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: PhotosCodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.sol = try container.decode(Int.self, forKey: .sol)
    self.imageSource = try container.decode(String.self, forKey: .imgsrc)
    self.earthDate = try container.decode(String.self, forKey: .earthdate)
  }
  
}
