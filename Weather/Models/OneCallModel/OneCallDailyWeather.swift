//
//  OneCallDailyWeather.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import Foundation

struct OneCallDailyWeather: OneCallWeatherDto {
   
    var temp: DailyTemp
    var feelsLike: DailyFeelsLike
    
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

struct DailyTemp: Codable {
    var day: Double
    var min: Double
    var max: Double
    var night: Double
    var eve: Double
    var morn: Double
}

struct DailyFeelsLike: Codable {
    var day: Double
    var night: Double
    var eve: Double
    var morn: Double
}
