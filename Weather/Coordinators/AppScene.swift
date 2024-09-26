//
//  AppScene.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import SwiftUI

enum AppScene: Hashable {
    case weatherHome(coord: GeoCoordinate)
    case searchCityList
}

extension AppScene {
    var identifier: String {
        switch self {
        case .weatherHome(_): return "weatherHome"
        case .searchCityList: return "searchCityList"
        }
    }
}
