//
//  SearchResultCell.swift
//  MKLocalSearchApp
//
//  Created by Florian Schmidt on 05.12.18.
//  Copyright © 2018 elmland.blog. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class SearchResultCell: UITableViewCell {
    
    public static let ID: String = "search.result.cell.id"
    
    var mapItem: MKMapItem? {
        didSet {
            if let m = mapItem  {
                countryLabel.text = m.countryLine()
                addressLabel.text = m.addressLine()
            }
        }
    }
    
    lazy var iconImageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = UIImage(named: "flag")
        i.contentMode = .scaleAspectFit
        i.tintColor = .red
        return i
    }()
    
    lazy var addressLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.adjustsFontSizeToFitWidth = true
        l.font = UIFont.systemFont(ofSize: 13)
        return l
    }()
    
    lazy var countryLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.adjustsFontSizeToFitWidth = true
        l.font = UIFont.systemFont(ofSize: 11)
        
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        customizeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func customizeView(){
        contentView.addSubview(iconImageView)
        contentView.addSubview(addressLabel)
        contentView.addSubview(countryLabel)
        
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        addressLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10).isActive = true
        addressLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        addressLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        countryLabel.leftAnchor.constraint(equalTo: addressLabel.leftAnchor).isActive = true
        countryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        countryLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
