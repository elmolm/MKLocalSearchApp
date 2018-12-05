//
//  ViewController.swift
//  MKLocalSearchApp
//
//  Created by Florian Schmidt on 05.12.18.
//  Copyright © 2018 elmland.blog. All rights reserved.
//

import UIKit
import MapKit
class MainViewController: UIViewController {
    
    var searchController: UISearchController!
    
    lazy var streetLabel: UILabel = {
       return createLabel()
    }()
    
    lazy var countryLabel: UILabel = {
        return createLabel()
    }()
    
    lazy var houseNrLabel: UILabel = {
        return createLabel()
    }()
    
    lazy var zip: UILabel = {
        return createLabel()
    }()
    
    lazy var cityLabel: UILabel = {
        return createLabel()
    }()
    
    lazy var countryCodeLabel: UILabel = {
        return createLabel()
    }()
    
    lazy var latLabel: UILabel = {
        return createLabel()
    }()
    
    lazy var longLabel: UILabel = {
        return createLabel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView()
        initSearchBar()
    }
    
    fileprivate func customizeView(){
        view.backgroundColor = UIColor.white
        
        view.addSubview(streetLabel)
        view.addSubview(houseNrLabel)
        view.addSubview(zip)
        view.addSubview(cityLabel)
        view.addSubview(countryLabel)
        view.addSubview(countryCodeLabel)
        view.addSubview(latLabel)
        view.addSubview(longLabel)
        
        streetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        streetLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40).isActive = true
        
        houseNrLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        houseNrLabel.topAnchor.constraint(equalTo: streetLabel.bottomAnchor, constant: 5).isActive = true
        
        zip.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        zip.topAnchor.constraint(equalTo: houseNrLabel.bottomAnchor, constant: 5).isActive = true
        
        cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        cityLabel.topAnchor.constraint(equalTo: zip.bottomAnchor, constant: 5).isActive = true
        
        countryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        countryLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5).isActive = true
        
        countryCodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        countryCodeLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 5).isActive = true
        
        latLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        latLabel.topAnchor.constraint(equalTo: countryCodeLabel.bottomAnchor, constant: 5).isActive = true
        
        longLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        longLabel.topAnchor.constraint(equalTo: latLabel.bottomAnchor, constant: 5).isActive = true
    
    }
    
    fileprivate func initSearchBar(){
        let controller = SearchController()
        controller.delegate = self
        
        searchController = UISearchController(searchResultsController: controller)
        searchController.searchResultsUpdater = controller
        
        let searchBar = searchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search address"
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        navigationItem.titleView = searchBar
    }
    
    fileprivate func createLabel() -> UILabel {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.tintColor = UIColor.darkGray
        l.font = UIFont.boldSystemFont(ofSize: 15)
        
        return l
    }
}

extension MainViewController: SearchResultDelegate {
    func foundResult(mapItem: MKMapItem) {
        streetLabel.text = "Street: \(mapItem.placemark.thoroughfare ?? "")"
        houseNrLabel.text = "HouseNr: \(mapItem.placemark.subThoroughfare ?? "")"
        cityLabel.text = "City: \(mapItem.placemark.locality ?? "")"
        countryLabel.text = "Country: \(mapItem.placemark.country ?? "")"
        countryCodeLabel.text = "Country code: \(mapItem.placemark.countryCode ?? "")"
        latLabel.text = "Latitude: \(mapItem.placemark.coordinate.latitude)"
        longLabel.text = "Longitude: \(mapItem.placemark.coordinate.longitude)"
        
        // clear search phrase
        searchController.searchBar.text = ""
    }
}

