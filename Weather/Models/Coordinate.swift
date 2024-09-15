//
//  Coordinate.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation

struct GeoCoordinate: Codable, Identifiable {
    let lat: Double
    let lon: Double
    
    var id: UUID? = UUID()
}

