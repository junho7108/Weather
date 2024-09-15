//
//  WeatherCondition.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation

enum WeatherCondition: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case drizzle = "Drizzle"
    case thunderstorm = "Thunderstorm"
    case snow = "Snow"
    case mist = "Mist"
    case smoke = "Smoke"
    case haze = "Haze"
    case dust = "Dust"
    case fog = "Fog"
    case sand = "Sand"
    case ash = "Ash"
    case squall = "Squall"
    case tornado = "Tornado"
    
  
}

//MARK: -
extension WeatherCondition {
    var description: String {
        switch self {
        case .clear: return "맑음"
        case .clouds: return "구름"
        case .rain: return "비"
        case .drizzle: return "이슬비"
        case .thunderstorm: return "천둥번개"
        case .snow: return "눈"
        case .mist: return "안개"
        case .smoke: return "연기"
        case .haze: return "연무"
        case .dust: return "먼지"
        case .fog: return "짙은 안개"
        case .sand: return "모래바람"
        case .ash: return "화산재"
        case .squall: return "돌풍"
        case .tornado: return "토네이도"
        }
    }
}

//MARK: -
extension WeatherCondition {
    init?(rawValue: String) {
        switch rawValue {
        case "Clear":
            self = .clear
        case "Clouds":
            self = .clouds
        case "Rain":
            self = .rain
        case "Drizzle":
            self = .drizzle
        case "Thunderstorm":
            self = .thunderstorm
        case "Snow":
            self = .snow
        case "Mist":
            self = .mist
        case "Smoke":
            self = .smoke
        case "Haze":
            self = .haze
        case "Dust":
            self = .dust
        case "Fog":
            self = .fog
        case "Sand":
            self = .sand
        case "Ash":
            self = .ash
        case "Squall":
            self = .squall
        case "Tornado":
            self = .tornado
        default:
            return nil
        }
    }
}
