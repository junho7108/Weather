//
//  ForecaseWeather.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation

struct ForecaseWeather: Codable, Identifiable, Equatable {
    let main: WeatherDetail
    let weather: [Weather]
    let clouds: Cloud
    let wind: Wind
    
    var date: String = ""
    var id: UUID = UUID()
    
    enum CodingKeys: String, CodingKey {
        case main = "main"
        case weather = "weather"
        case clouds = "clouds"
        case wind = "wind"
        case date = "dt_txt"
    }
}

extension ForecaseWeather: DateFormatterProtocol {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.main = try container.decode(WeatherDetail.self, forKey: .main)
        self.weather = try container.decode([Weather].self, forKey: .weather)
        self.clouds = try container.decode(Cloud.self, forKey: .clouds)
        self.wind = try container.decode(Wind.self, forKey: .wind)
        
        let utcDate = try container.decode(String.self, forKey: .date)
        self.date = convertUTCToKST(utcDateString: utcDate)!
   
    }
}
