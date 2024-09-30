//
//  Wind.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation

struct Wind: Codable, Equatable {
    let speed: Double
    let deg: Int
    let gust: Double?
}
