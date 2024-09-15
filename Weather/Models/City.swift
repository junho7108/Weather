//
//  City.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import Foundation

struct City: Codable {
    struct Coordinate: Codable { var lat: Double; var lon: Double }
    
    let id: Int
    let name: String
    let country: String
    let coord: Coordinate
}

extension City: Identifiable { }
