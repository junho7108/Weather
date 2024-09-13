//
//  WeatherResponse.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import Foundation

struct WeatherResponse: Codable {
    var lat: Double
    var lon: Double
    var current: [Weather]
    var hourly: [Weather]
    var daily: [DailyWeather]
}
