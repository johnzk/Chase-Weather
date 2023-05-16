//
//  SearchResultsTableViewCell.swift
//  Chase Weather
//
//  Created by John Kang on 5/15/23.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    var resultLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(resultLabel)
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            resultLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            resultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            resultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
