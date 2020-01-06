//
//  PhotoCollectionViewCell.swift
//  NASA App
//
//  Created by Arwin Oblea on 1/4/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
  
  var photoView: UIImageView!
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    photoView = UIImageView(frame: self.contentView.frame)
    photoView.contentMode = .scaleToFill
    photoView.isUserInteractionEnabled = false
    photoView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(photoView)
  }
  
  // setup cell layout
  override func layoutSubviews() {
    super.layoutSubviews()
    
    NSLayoutConstraint.activate([
      contentView.leadingAnchor.constraint(equalTo: photoView.leadingAnchor),
      contentView.topAnchor.constraint(equalTo: photoView.topAnchor),
      contentView.trailingAnchor.constraint(equalTo: photoView.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: photoView.bottomAnchor)
    ])
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
