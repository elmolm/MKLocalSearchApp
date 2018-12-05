//
//  me.swift
//  MKLocalSearchApp
//
//  Created by Florian Schmidt on 05.12.18.
//  Copyright © 2018 elmland.blog. All rights reserved.
//

import Foundation
import MapKit

extension MKMapItem {
    func addressLine() -> String {
        var addressParts: [String] = []
        
        if let street = self.placemark.thoroughfare {
            if let nr = self.placemark.subThoroughfare {
                addressParts.append("\(street) \(nr)")
            } else {
                addressParts.append(street)
            }
        }
        
        if let city = self.placemark.locality {
            addressParts.append(city)
        }
        
        if let postalCode = self.placemark.postalCode {
            addressParts.append(postalCode)
        }
        
        if addressParts.isEmpty {
            return "-"
        } else {
            return addressParts.joined(separator: ", ")
        }
    }
    
    func countryLine() -> String {
        var countryParts: [String] = []
        
        if let countryCode = self.placemark.isoCountryCode {
            countryParts.append(countryCode)
        }
        
        if let country = self.placemark.country {
            countryParts.append(country)
        }
        
        if countryParts.isEmpty {
            return "-"
        } else {
            return countryParts.joined(separator: ", ")
        }
    }
}
