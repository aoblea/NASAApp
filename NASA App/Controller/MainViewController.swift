//
//  MainViewController.swift
//  NASA App
//
//  Created by Arwin Oblea on 1/2/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  // MARK: - Properties
  
  lazy var client = NASAClient()
  lazy var locationManager = LocationManager.sharedInstance
  
  lazy var flowLayout: UICollectionViewFlowLayout = {
    let spacing: CGFloat = 2.0
    let numberOfItemsPerRow: CGFloat = 3.0
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = spacing
    layout.minimumInteritemSpacing = spacing
    let itemSize = CGSize(width: self.view.frame.size.width/numberOfItemsPerRow-spacing, height: self.view.frame.size.width/numberOfItemsPerRow-spacing)
    layout.itemSize = itemSize
    
    return layout
  }()
  
  lazy var postCardMakerButton: UIButton = {
    let button = UIButton()
    button.setTitle("Rover Postcard Maker", for: .normal)
    button.setBackgroundImage(UIImage(named: "mars_rover"), for: .normal)
    button.addTarget(self, action: #selector(handlePostCardMakerButton), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  lazy var eyeInTheSkyButton: UIButton = {
    let button = UIButton()
    button.setTitle("Eye In The Sky", for: .normal)
    button.setBackgroundImage(UIImage(named: "eye_in_the_sky"), for: .normal)
    button.setTitleColor(UIColor.black, for: .normal)
    button.addTarget(self, action: #selector(handleEyeInTheSkyButton), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  var menuStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  // MARK: - Viewdidload
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.requestLocationAuthorization()
    setupNavBar()
    setupUI()
    
  }
  
  private func setupNavBar() {
    navigationController?.navigationBar.barTintColor = UIColor.AppTheme.oxfordBlue
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.AppTheme.isabelline]
  }
  
  private func setupUI() {
    title = "NASA App"
    
    menuStackView.addArrangedSubview(postCardMakerButton)
    menuStackView.addArrangedSubview(eyeInTheSkyButton)
    view.addSubview(menuStackView)
    
    // Constraints
    NSLayoutConstraint.activate([
      menuStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      menuStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      menuStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      menuStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  // Send user to Postcard Maker feature
  @objc private func handlePostCardMakerButton() {
    let marsRoverPhotoCVC = MarsRoverPhotosCollectionViewController(collectionViewLayout: flowLayout)
    
    // Begin fetching photos while transitioning to next viewcontroller
    client.getMarsPhotos { (results) in
      switch results {
      case .success(let marsPhotos):
        marsRoverPhotoCVC.photos = marsPhotos.photos
        marsRoverPhotoCVC.collectionView.reloadData()
      case .failure(let error):
        self.presentAlert(title: "Networking Error", message: "\(error.localizedDescription)")
      }
    }
    
    self.navigationController?.pushViewController(marsRoverPhotoCVC, animated: true)
  }
  
  // Send user to Eye In The Sky feature
  @objc private func handleEyeInTheSkyButton() {
    let eyeInTheSkyVC = EyeInTheSkyViewController()
    self.navigationController?.pushViewController(eyeInTheSkyVC, animated: true)
  }

}
