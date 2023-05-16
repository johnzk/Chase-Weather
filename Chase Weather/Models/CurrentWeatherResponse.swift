//
//  CurrentWeatherResponse.swift
//  Chase Weather
//
//  Created by John Kang on 5/15/23.
//

import Foundation

struct CurrentWeatherResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Rain: Codable {
    
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

// MARK: Bulk Response

struct BulkCurrentWeatherResponse: Codable {
    let cnt: Int
    let list: [CurrentWeatherResponseOld]
}

struct CurrentWeatherResponseOld: Codable {
    let coord: Coord
    let sys: SysOld
    let weather: [Weather]
    let main: MainOld
    let visibility: Int
    let wind: WindOld
    let clouds: Clouds
    let dt: Int
    let id: Int
    let name: String
}

struct SysOld: Codable {
    let country: String
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

struct WindOld: Codable {
    let speed: Double
    let deg: Int
}

struct MainOld: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}
