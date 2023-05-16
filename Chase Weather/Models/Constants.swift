//
//  Constants.swift
//  Chase Weather
//
//  Created by John Kang on 5/15/23.
//

import Foundation

struct Constants {
    static let apiKey = "8246482203cbcc0e6737acc1ecbbc815"
    static var urlTail: String {
        "&appid=" + apiKey
    }
    static let singleCityRestUrl = "https://api.openweathermap.org/data/2.5/weather?id="
    static let bulkCityRestUrl = "https://api.openweathermap.org/data/2.5/group?id="
    static let geoRestUrl = "https://api.openweathermap.org/geo/1.0/direct?q="
    static let geoLimit = "&limit=5"
    static let allBase = "https://api.openweathermap.org/data/2.5/weather?"
    static let latBase = "lat="
    static let lonBase = "&lon="
    
    static func formBaseUrl(cityID: String) -> String {
        singleCityRestUrl + cityID + urlTail
    }
    
    static func formBulkUrl(cityIDs: [String]) -> String {
        bulkCityRestUrl + (cityIDs.map {String($0)}).joined(separator: ",") + urlTail
    }
    
    static func formGeoUrl(query: String) -> String {
        geoRestUrl + query + geoLimit + urlTail
    }
    
    static func formBaseUrl(lat: Double, lon: Double) -> String {
        allBase + latBase + String(lat) + lonBase + String(lon) + urlTail
    }
}

struct Formulas {
    static func kelvinToFarenheit(_ kelvin: Double) -> Double {
        (kelvin - 273.15) * 9.0/5.0 + 32.0
    }
}
