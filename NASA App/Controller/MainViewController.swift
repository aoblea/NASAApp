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
    button.backgroundColor = UIColor.red
    button.addTarget(self, action: #selector(handlePostCardMakerButton), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  lazy var eyeInTheSkyButton: UIButton = {
    let button = UIButton()
    button.setTitle("Eye In The Sky", for: .normal)
    button.backgroundColor = UIColor.blue
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
    
    setupNavBar()
    setupUI()

  }
  
  private func setupNavBar() {
    title = "NASA App"
    navigationController?.navigationBar.barTintColor = UIColor.AppTheme.oxfordBlue
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.AppTheme.isabelline]
  }
  
  private func setupUI() {
    menuStackView.addArrangedSubview(postCardMakerButton)
    menuStackView.addArrangedSubview(eyeInTheSkyButton)
    view.addSubview(menuStackView)
    
    NSLayoutConstraint.activate([
      menuStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      menuStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      menuStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      menuStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  @objc private func handlePostCardMakerButton() {
    print("go to post card maker")
    let marsRoverPhotoCVC = MarsRoverPhotosCollectionViewController(collectionViewLayout: flowLayout)
    
    client.getMarsPhotos { (results) in
      switch results {
      case .success(let marsPhotos):
        DispatchQueue.main.async {
          marsRoverPhotoCVC.photos = marsPhotos.photos

          if marsRoverPhotoCVC.photos.count == marsPhotos.photos.count {
            marsRoverPhotoCVC.collectionView.reloadData()
            print("Completed transferring \(marsPhotos.photos.count) photos.")
          }
        }
      case .failure(let error):
        print("\(error)")
      }
    }
    
    self.navigationController?.pushViewController(marsRoverPhotoCVC, animated: true)
  }
  
  @objc private func handleEyeInTheSkyButton() {
    print("go to eye in the sky")
  }

}
