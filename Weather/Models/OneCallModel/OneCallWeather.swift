//
//  OneCallWeather.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import Foundation

struct OneCallWeather: OneCallWeatherDto {
    typealias Temp = Double
    typealias FeelsLike = Double
    
    var temp: Double
    var feelsLike: Double
    
    var dt: Int
    var sunrise: Int?
    var sunset: Int?
    var pressure: Int
    var humidity: Int
    var dewPoint: Double
    var uvi: Double
    var clouds: Int
    var visibility: Int
    var windSpeed: Double
    var windDeg: Int
    var windGust: Double
    var weather: [OneCallWeatherDetail]
}
