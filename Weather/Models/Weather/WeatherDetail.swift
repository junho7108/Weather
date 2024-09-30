//
//  WeatherDetail.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation

struct WeatherDetail: Codable, Equatable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    let pressure: Int
    let humidity: Int
    let seaLevel: Int
    let grndLevel: Int
      
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

