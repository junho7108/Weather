//
//  OneCallWeatherDto.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import Foundation

protocol OneCallWeatherDto: Codable {
    
    associatedtype Temp: Decodable
    associatedtype FeelsLike: Decodable
    
    var dt: Int { get set }
    
    var sunrise: Int? { get set }
    var sunset: Int? { get set }
    
    var temp: Temp { get set }
    var feelsLike: FeelsLike { get set }
    var pressure: Int { get set }
    var humidity: Int { get set }
    var dewPoint: Double { get set }
    var uvi: Double { get set }
    var clouds: Int { get set }
    var visibility: Int { get set }
    
    var windSpeed: Double { get set }
    var windDeg: Int { get set }
    var windGust: Double { get set }
    
    var weather: [OneCallWeatherDetail] { get set }
}

//MARK: - Extensions

extension OneCallWeatherDto {
    init(from decoder: any Decoder) throws {
        try self.init(from: decoder)
        
        let values = try decoder.container(keyedBy: WeatherCodingKeys.self)
        self.dt = try values.decode(Int.self, forKey: .dt)
        
        self.sunrise = try values.decode(Int.self, forKey: .sunrise)
        self.sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
        
        self.temp = try values.decode(Temp.self, forKey: .temp)
        self.feelsLike = try values.decode(FeelsLike.self, forKey: .feelsLike)
        self.pressure = try values.decode(Int.self, forKey: .pressure)
        self.humidity = try values.decode(Int.self, forKey: .humidity)
        self.dewPoint = try values.decode(Double.self, forKey: .humidity)
        self.uvi = try values.decode(Double.self, forKey: .uvi)
        self.clouds = try values.decode(Int.self, forKey: .clouds)
        self.visibility = try values.decode(Int.self, forKey: .visibility)
        
        self.windSpeed = try values.decode(Double.self, forKey: .windSpeed)
        self.windDeg = try values.decode(Int.self, forKey: .windDeg)
        self.windGust = try values.decode(Double.self, forKey: .windGust)
        
        self.weather = try values.decode([OneCallWeatherDetail].self, forKey: .weather)
    }
}

//MARK: - WeatherCodingKeys

fileprivate enum WeatherCodingKeys: String, CodingKey {
    case dt = "dt"
    case sunrise = "sunrise"
    case sunset = "sunset"
    case temp = "temp"
    case feelsLike = "feels_like"
    case pressure = "pressure"
    case humidity = "humidity"
    case dewPoint = "dew_point"
    case uvi = "uvi"
    case clouds = "clouds"
    case visibility = "visibility"
    case windSpeed = "wind_speed"
    case windDeg = "wind_deg"
    case windGust = "wind_gust"
    case weather = "weather"
}


