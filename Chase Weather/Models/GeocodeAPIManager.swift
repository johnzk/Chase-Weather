//
//  GeocodeAPIManager.swift
//  Chase Weather
//
//  Created by John Kang on 5/15/23.
//

import Foundation

class GeocodeAPIManager {
    
    static let shared = GeocodeAPIManager()
    
    private init() {
        return
    }
    
    func fetchGeocodeResults(cityName: String, _ post: @escaping ([GeoLocale]) -> ()) {
        let url = Constants.formGeoUrl(query: cityName)
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data, error == nil else { return }
            
            var response: [GeoLocale]?
            do {
                response = try JSONDecoder().decode([GeoLocale].self, from: data)
            }
            catch {
                print(error)
            }
            
            guard let response else { return }
            
            post(response)
        }.resume()
    }
}

struct GeoResponse: Codable {
    let list: [GeoLocale]
}

struct GeoLocale: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String
}
