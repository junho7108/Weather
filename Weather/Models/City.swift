//
//  City.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import Foundation

struct City: Codable {
    struct Coordinate: Codable { var lat: Double; var lon: Double }
    
    var id: Int
    var name: String
    var country: String
    var coord: Coordinate
}
