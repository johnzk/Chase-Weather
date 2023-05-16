//
//  WeatherAPIManager.swift
//  Chase Weather
//
//  Created by John Kang on 5/15/23.
//

import Foundation

class WeatherAPIManager {
    
    static let shared = WeatherAPIManager()
    
    private init() {
        return
    }
    
    func fetchWeatherData(cityID: String, _ post: @escaping (CurrentWeatherResponse) -> ()) {
        let url = Constants.formBaseUrl(cityID: cityID)
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data, error == nil else { return }
            
            var response: CurrentWeatherResponse?
            do {
                response = try JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
            }
            catch {
                print(error)
            }
            
            guard let response else { return }
            
            post(response)
        }.resume()
    }
    
    func fetchBulkWeatherData(cityIDs: [String], _ post: @escaping (BulkCurrentWeatherResponse) -> ()) {
        let url = Constants.formBulkUrl(cityIDs: cityIDs)
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data, error == nil else { return }
            
            var response: BulkCurrentWeatherResponse?
            do {
                response = try JSONDecoder().decode(BulkCurrentWeatherResponse.self, from: data)
            }
            catch {
                print(error)
            }
            
            guard let response else { return }
            
            post(response)
        }.resume()
    }
    
    func fetchWeatherData(lat: Double, lon: Double, _ post: @escaping (CurrentWeatherResponse) -> ()) {
        let url = Constants.formBaseUrl(lat: lat, lon: lon)
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data, error == nil else { return }
            
            var response: CurrentWeatherResponse?
            do {
                response = try JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
            }
            catch {
                print(error)
            }
            
            guard let response else { return }
            
            post(response)
        }.resume()
    }
}
