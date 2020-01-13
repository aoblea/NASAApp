//
//  LocationSearchResultsTableViewController.swift
//  NASA App
//
//  Created by Arwin Oblea on 1/8/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import UIKit
import MapKit

fileprivate let reuseIdentifier = "LocationCell"

class LocationSearchResultsTableViewController: UITableViewController, UISearchResultsUpdating {
  // MARK: - Properties
  
  var searchResults: [MKMapItem] = []
  var filteredResults: [MKMapItem] = []
  var mapView: MKMapView?
  var imageView: UIImageView?
  
  lazy var client = NASAClient()
  
  // MARK: Init
  
  override init(style: UITableView.Style) {
    super.init(style: style)
  }
  
  init(map: MKMapView, image: UIImageView) {
    self.mapView = map
    self.imageView = image
    
    super.init(style: .plain)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Viewdidload
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredResults.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    
    cell.textLabel?.text = filteredResults[indexPath.row].name
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // obtain coordinates, set mapview, fetches image based on selected row
    let selectedCoordinates = filteredResults[indexPath.row].placemark.coordinate
    
    guard let mapView = mapView else { return self.presentAlert(title: "Nonexistent", message: "Mapview is nil.") }
    
    let radius: CLLocationDistance = 200
    let region = MKCoordinateRegion(center: selectedCoordinates, latitudinalMeters: radius, longitudinalMeters: radius)
    mapView.setRegion(region, animated: true)
    
    mapView.removeAnnotations(mapView.annotations) // removes any annotations for new annotations
    let location = MKPointAnnotation()
    location.title = filteredResults[indexPath.row].name
    location.coordinate = selectedCoordinates
    mapView.addAnnotation(location)
    
    // get the image
    client.getEarthImagery(latitude: selectedCoordinates.latitude.description, longitude: selectedCoordinates.longitude.description) { (results) in
      switch results {
      case .success(let earthImagery):
        guard let url = URL(string: earthImagery.imageURLString) else { return self.presentAlert(title: "Network Error", message: "Url is nil.") }
        self.imageView?.kf.indicatorType = .activity
        self.imageView?.kf.setImage(with: url)
      case .failure(let error):
        self.presentAlert(title: "Networking Error", message: "\(error.localizedDescription)")
      }
    }
    
    dismiss(animated: true, completion: nil)
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else { return }
    
    if !searchText.isEmpty {
      let request = MKLocalSearch.Request()
      request.naturalLanguageQuery = searchText
      
      
      let search = MKLocalSearch(request: request)
      search.start { [unowned self] (response, error) in
        guard let resp = response else { return }
        
        self.searchResults.removeAll()
        self.searchResults.append(contentsOf: resp.mapItems)
        
        self.filteredResults = self.searchResults.filter { $0.name!.lowercased().contains(searchText.lowercased()) }
        
        // refreshes table view
        self.refresh()
      }
    } else {
      searchResults.removeAll()
      filteredResults.removeAll()
      
      refresh()
    }
    
  }
  
  private func refresh() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
}
