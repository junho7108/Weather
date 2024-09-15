//
//  DailyTemperature.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation

struct DailyTemperature: Identifiable {
    let date: String
    let maxTemp: Double
    let minTemp: Double
    
    var id: UUID = UUID()
}
