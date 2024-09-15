//
//  ForecaseWeatherResponse.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation

struct ForecaseWeatherResponse: Codable {
    let cod: String
    let cnt: Int
    
    let list: [ForecaseWeather]
}
