//
//  Weather.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation

struct Weather: Codable, Equatable {
    let id: Int
    let main: WeatherCondition
    let description: String
    let icon: String
}
