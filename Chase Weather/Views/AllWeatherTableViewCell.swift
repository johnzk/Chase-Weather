//
//  AllWeatherTableViewCell.swift
//  Chase Weather
//
//  Created by John Kang on 5/12/23.
//

import UIKit

class AllWeatherTableViewCell: UITableViewCell {
    
    var conditionImageView = UIImageView()
    var locationLabel = UILabel()
    var temperatureLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(conditionImageView)
        addSubview(locationLabel)
        addSubview(temperatureLabel)
        
        configureConditionImageView()
        configureLocationLabel()
        configureTemperatureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func injectData(conditionImage: UIImage, locationText: String, temperatureText: String) {
        conditionImageView.image = conditionImage
        locationLabel.text = locationText
        temperatureLabel.text = temperatureText
    }
    
    func configureConditionImageView() {
        conditionImageView.contentMode = .scaleAspectFill
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conditionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            conditionImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            conditionImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            conditionImageView.widthAnchor.constraint(equalTo: conditionImageView.heightAnchor, multiplier: 1.0)
        ])
    }
    
    func configureLocationLabel() {
        locationLabel.font = UIFont.boldSystemFont(ofSize: 20)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            locationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            locationLabel.leadingAnchor.constraint(equalTo: conditionImageView.trailingAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: -8)
        ])
    }
    
    func configureTemperatureLabel() {
        temperatureLabel.font = .boldSystemFont(ofSize: 25)
        temperatureLabel.textAlignment = .center
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}
