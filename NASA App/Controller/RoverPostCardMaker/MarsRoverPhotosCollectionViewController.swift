//
//  MarsRoverPhotosCollectionViewController.swift
//  NASA App
//
//  Created by Arwin Oblea on 1/3/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "PhotoCell"

/*
 This controller is where the photos are loaded into a collection view where the user will select a photo for the editing process.
 I am using Kingfisher framework to help load and cache the images that are fetched from the client.
 */
class MarsRoverPhotosCollectionViewController: UICollectionViewController {
  // MARK: - Properties
  
  var photos: [Photo] = []
  lazy var client = NASAClient()
  
  let editPhotoViewController = EditPhotoViewController()
  
  // MARK: - Viewdidload
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Select a photo"

    setupCollectionView()
  }
  
  func setupCollectionView() {
    // Register cell classes
    self.collectionView!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
  }
  
  // MARK: UICollectionView data source methods

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
    
    var photo = photos[indexPath.row]
    
    let url = URL(string: photo.imageSource)
    cell.photoView.kf.indicatorType = .activity
    cell.photoView.kf.setImage(with: url)
    
    // appends retrieved image from url to photo.image
    KingfisherManager.shared.retrieveImage(with: url!) { (results) in
      switch results {
      case .success(let retrievedImage):
        photo.image = retrievedImage.image
      case .failure(let error):
        self.presentAlert(title: "Networking Error", message: "\(error.localizedDescription)")
      }
    }
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // when the user selects an image, it will then send the user to the next page where editing will take place.
    let selectedPhoto = photos[indexPath.row]
    editPhotoViewController.photo = selectedPhoto
    let url = URL(string: selectedPhoto.imageSource)
    editPhotoViewController.imageView.kf.setImage(with: url)

    self.navigationController?.pushViewController(editPhotoViewController, animated: true)
  }
  
}
