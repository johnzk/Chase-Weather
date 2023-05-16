//
//  SearchResultsViewController.swift
//  Chase Weather
//
//  Created by John Kang on 5/15/23.
//

import UIKit

class SearchResultsViewController: UITableViewController {

    let cellIdentifier = "SearchResultsTableViewCell"
    var tableEntries: [GeoLocale] = []
    weak var parentVC: SearchLocationViewController? = nil
    
    init(parentVC: SearchLocationViewController) {
        super.init(nibName: nil, bundle: nil)
        self.parentVC = parentVC
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableEntries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! SearchResultsTableViewCell
        let geoLocale = tableEntries[indexPath.row]
        cell.resultLabel.text = "\(geoLocale.name), \(geoLocale.state), \(geoLocale.country)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coor = tableEntries[indexPath.row]
        WeatherAPIManager.shared.fetchWeatherData(lat: coor.lat, lon: coor.lon) { currentWeatherResponse in
            DispatchQueue.main.async {
                CoreDataManager.shared.createCurrentCondition(currentWeatherResponse)
                self.parentVC?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func reloadTable(cityName: String) {
        GeocodeAPIManager.shared.fetchGeocodeResults(cityName: cityName) { GeoLocaleList in
            self.tableEntries = []
            for geoEntry in GeoLocaleList {
                self.tableEntries.append(geoEntry)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    

    // MARK: - Table view data source

}
