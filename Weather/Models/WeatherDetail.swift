//
//  WeatherDetail.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import Foundation

struct WeatherDetail: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
