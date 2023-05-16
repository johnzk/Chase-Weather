//
//  WeatherDetailTableViewCell.swift
//  Chase Weather
//
//  Created by John Kang on 5/15/23.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {

    var itemNameLabel = UILabel()
    var itemValueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(itemNameLabel)
        addSubview(itemValueLabel)
        
        itemNameLabel.font = .boldSystemFont(ofSize: 17)
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            itemNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            itemNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            itemNameLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        itemValueLabel.textAlignment = .right
        itemValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemValueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            itemValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            itemValueLabel.leadingAnchor.constraint(equalTo: itemNameLabel.trailingAnchor, constant: 8),
            itemValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
