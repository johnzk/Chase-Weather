//
//  WeatherDetailViewController.swift
//  Chase Weather
//
//  Created by John Kang on 5/15/23.
//

import UIKit

class WeatherDetailViewController: UITableViewController {

    let cellIdentifier = "WeatherDetailTableViewCell"
    var currentCondition: CurrentCondition? = nil
    
    init(currentCondition: CurrentCondition? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.currentCondition = currentCondition
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let cc = currentCondition {
            title = cc.name
        } else {
            title = ""
        }
        
        tableView.tableHeaderView = configureTableViewHeader()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherDetailTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func configureTableViewHeader() -> UIView {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))
        let i: UIImageView
        if let value = currentCondition?.icon {
            i = UIImageView(image: UIImage(named: value))
        } else {
            i = UIImageView(image: UIImage(named: "01d"))
        }
        let l = UILabel()
        navigationController?.navigationBar.prefersLargeTitles = true
        if let value = currentCondition?.temp {
            l.text = "\(Int(Formulas.kelvinToFarenheit(value)))°F"
        } else {
            l.text = "None"
        }
        l.font = UIFont.boldSystemFont(ofSize: 25)
        v.addSubview(i)
        i.translatesAutoresizingMaskIntoConstraints = false
        i.heightAnchor.constraint(equalToConstant: 150).isActive = true
        i.widthAnchor.constraint(equalTo: i.heightAnchor).isActive = true
        i.leadingAnchor.constraint(equalTo: v.leadingAnchor).isActive = true
        v.addSubview(l)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.heightAnchor.constraint(equalToConstant: 150).isActive = true
        l.widthAnchor.constraint(equalTo: l.heightAnchor).isActive = true
        l.leadingAnchor.constraint(equalTo: i.trailingAnchor).isActive = true
        
        return v
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! WeatherDetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.itemNameLabel.text = "Description"
            if let value = currentCondition?.desc {
                cell.itemValueLabel.text = "\(value.capitalized)"
            } else {
                cell.itemValueLabel.text = "None"
            }
        case 1:
            cell.itemNameLabel.text = "High Temperature"
            if let value = currentCondition?.hi_temp {
                cell.itemValueLabel.text = "\(Int(Formulas.kelvinToFarenheit(value)))°F"
            } else {
                cell.itemValueLabel.text = "None"
            }
        case 2:
            cell.itemNameLabel.text = "Low Temperature"
            if let value = currentCondition?.lo_temp {
                cell.itemValueLabel.text = "\(Int(Formulas.kelvinToFarenheit(value)))°F"
            } else {
                cell.itemValueLabel.text = "None"
            }
        case 3:
            cell.itemNameLabel.text = "Humidity"
            if let value = currentCondition?.humidity {
                cell.itemValueLabel.text = "\(value)%"
            } else {
                cell.itemValueLabel.text = "None"
            }
        default:
            break
            
        }
        cell.selectionStyle = .none
        return cell
    }
}
