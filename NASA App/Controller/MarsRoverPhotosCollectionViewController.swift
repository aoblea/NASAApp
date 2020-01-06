//
//  MarsRoverPhotosCollectionViewController.swift
//  NASA App
//
//  Created by Arwin Oblea on 1/3/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

// This controller is where the user selects a photo to edit on
class MarsRoverPhotosCollectionViewController: UICollectionViewController {
  
  // MARK: - Properties
  
  var photos: [Photo] = []
  let client = NASAClient()
  
  
  // MARK: - Viewdidload
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    // Register cell classes
    self.collectionView!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
  }
  
  // MARK: UICollectionViewDataSource

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
    let photo = photos[indexPath.row]
    
    
    return cell
  }
  

}
