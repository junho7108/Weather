//
//  City.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import Foundation

struct City: Codable, Equatable {
    let id: Int
    let name: String
    let country: String
    let coord: GeoCoordinate
}

extension City: Identifiable { }
