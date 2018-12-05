//
//  SearchController.swift
//  MKLocalSearchApp
//
//  Created by Florian Schmidt on 05.12.18.
//  Copyright © 2018 elmland.blog. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class SearchController: UIViewController {
    
    var delegate: SearchResultDelegate?
    var searchTimer: Timer?
    var searchResults: [MKMapItem] = []
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.tableFooterView = UIView()
        t.dataSource = self
        t.delegate = self
        
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.ID)
        
        customizeView()
    }
    
    fileprivate func customizeView(){
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchPhrase = searchController.searchBar.text else { return }
        
        
        /*
         If you send multiple simultanious requests to apple you get an MKErrorLoadingThrottled error (="MKErrorDomain error 3"). To prevent getting such errors you shouldn't send a local search request on each search phrase change. You have to delay the requests.
         On each search phrase change the timer gets invalidated and reinitialized with a time interval of 0.5 seconds. This means, that the timer only fires when there was no search phrase change for the last 0.5 seconds. As soon as the timer fires the local search will be submitted.
         */
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (timer) in
            self.localSearchFor(phrase: searchPhrase)
        })
    }
    
    fileprivate func localSearchFor(phrase: String){
        
        /* Don't send empty search phrases */
        if phrase.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty  {
            searchResults.removeAll()
            tableView.reloadData()
            return
        }
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = phrase
        
        let localSearch = MKLocalSearch(request: searchRequest)
        
        localSearch.start { response, error in
            /* on error (no response) clear results and reload tableView */
            guard let searchResponse = response else {
                self.searchResults.removeAll()
                self.tableView.reloadData()
                return
            }
            
            self.searchResults = searchResponse.mapItems
            self.tableView.reloadData()
        }
    }
}

extension SearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchResultCell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.ID, for: indexPath) as! SearchResultCell
        
        cell.mapItem = searchResults[indexPath.row]
        
        return cell
    }
}

extension SearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.foundResult(mapItem: searchResults[indexPath.row])
        
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
