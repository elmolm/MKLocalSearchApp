//
//  SearchResultDelegate.swift
//  MKLocalSearchApp
//
//  Created by Florian Schmidt on 05.12.18.
//  Copyright © 2018 elmland.blog. All rights reserved.
//

import Foundation
import MapKit

protocol SearchResultDelegate {
    func foundResult(mapItem: MKMapItem)
}
