//
//  OneCallWeatherResponse.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import Foundation

struct OneCallWeatherResponse: Codable {
    let lat: Double
    let lon: Double
    let current: [OneCallWeather]
    let hourly: [OneCallWeather]
    let daily: [OneCallDailyWeather]
}
