//
//  DailyTemperature.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation

struct DailyTemperature: Identifiable, Equatable {
    let date: String
    let maxTemp: Double
    let minTemp: Double
    let icon: String?
    
    var id: UUID = UUID()
}
