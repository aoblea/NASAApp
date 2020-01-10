//
//  EyeInTheSkyViewController.swift
//  NASA App
//
//  Created by Arwin Oblea on 1/7/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import UIKit
import MapKit

class EyeInTheSkyViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
  // MARK: - Properties
  
  lazy var client = NASAClient()
  var locationResultsTVC: LocationSearchResultsTableViewController?
  var searchController = UISearchController()
  
  lazy var mapView: MKMapView = {
    let map = MKMapView()
    map.translatesAutoresizingMaskIntoConstraints = false
    return map
  }()
  
  lazy var satelliteImageView: UIImageView = {
    let view = UIImageView()
    view.backgroundColor = UIColor.AppTheme.oxfordBlue
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var viewStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  // MARK: - Viewdidload
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupSearchBar()
  }
    
  private func setupUI() {
    self.title = "Eye In The Sky"
    
    viewStack.addArrangedSubview(mapView)
    viewStack.addArrangedSubview(satelliteImageView)
    
    view.addSubview(viewStack)
    
    // Constraints
    NSLayoutConstraint.activate([
      viewStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      viewStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      viewStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      viewStack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  private func setupSearchBar() {
    locationResultsTVC = LocationSearchResultsTableViewController(map: self.mapView, image: self.satelliteImageView)
    searchController = UISearchController(searchResultsController: locationResultsTVC)
    searchController.delegate = self
    searchController.searchResultsUpdater = self.locationResultsTVC
    searchController.searchBar.autocapitalizationType = .none
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "Search keyword"
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.hidesNavigationBarDuringPresentation = true
    searchController.searchBar.barStyle = .black // changes search text color to white
    
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
  }
  
}
