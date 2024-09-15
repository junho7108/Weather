//
//  Double+Extensions.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation

extension Double {
    func kelvinToCelsiusString() -> String {
        let mutatingSelf = self
        let celsius = mutatingSelf - 273.15
        let roundedCelsius = Int(celsius.rounded())
        return "\(roundedCelsius)°"
    }
}
