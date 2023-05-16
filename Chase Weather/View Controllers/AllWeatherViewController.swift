//
//  AllWeatherViewController.swift
//  Chase Weather
//
//  Created by John Kang on 5/12/23.
//

import UIKit

class AllWeatherViewController: UITableViewController {
    
    var forecasts: [CurrentCondition] = []
    
    var state: String? = UserDefaults.standard.string(forKey: "state")
    var flag: Int? = nil
    
    let cellIdentifier = "AllWeatherTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        
        if let stateString = state {
            if let row = Int(stateString) {
                flag = row
            }
            state = nil
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CoreDataManager.shared.getAllCurrentCondition()
        forecasts = CoreDataManager.shared.currentConditions
        tableView.reloadData()
        
        if let f = flag {
            manuallyPushVC(row: f)
            flag = nil
        }
        else {
            UserDefaults.standard.set("", forKey: "state")
        }
    }
    
    func configureViewController() {
        title = "All Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        let addLocationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocation))
        navigationItem.rightBarButtonItem = addLocationButton
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.register(AllWeatherTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! AllWeatherTableViewCell
        let data = forecasts[indexPath.row]
        cell.injectData(conditionImage: UIImage(named: data.icon!)!, locationText: data.name!, temperatureText: "\( Int(Formulas.kelvinToFarenheit(data.temp)) )°F")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(String(indexPath.row), forKey: "state")
        navigationController?.pushViewController(WeatherDetailViewController(currentCondition: forecasts[indexPath.row]), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.deleteCurrentCondition(forecasts[indexPath.row])
            self.forecasts = CoreDataManager.shared.currentConditions
            self.tableView.reloadData()
        }
    }
    
    @objc func addLocation() {
        let actionSheet = UIAlertController(title: "Add Weather Location", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Search by Name", style: .default) {_ in
            self.navigationController?.pushViewController(SearchLocationViewController(), animated: true)
        })
        actionSheet.addAction(UIAlertAction(title: "Use Current Location", style: .default) {_ in
            LocationManager.shared.getLocation({ location in
                    WeatherAPIManager.shared.fetchWeatherData(lat: Double(location.coordinate.latitude), lon: Double(location.coordinate.longitude)) { currentWeatherResponse in
                        DispatchQueue.main.async {
                            CoreDataManager.shared.createCurrentCondition(currentWeatherResponse)
                            self.forecasts = CoreDataManager.shared.currentConditions
                            self.tableView.reloadData()
                        }
                    }
            }, handleNoPermission: {
                let alert = UIAlertController(title: "Location Permission Denied", message: "Please go to settings and allow location permission to enable current location.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
                self.present(alert, animated: true)
            })
        })
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
    }
    
    func manuallyPushVC(row: Int) {
        navigationController?.pushViewController(WeatherDetailViewController(currentCondition: forecasts[row]), animated: true)
    }
}
