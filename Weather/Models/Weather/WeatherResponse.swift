//
//  WeatherResponse.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation

struct WeatherResponse: Codable {
    let coord: Coordinate
    let weather: [Weather]
    let main: WeatherDetail
    let wind: Wind
    var clouds: Cloud
    let name: String
    let id: Int
}
