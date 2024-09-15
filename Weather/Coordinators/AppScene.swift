//
//  AppScene.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation

enum AppScene: Hashable {
    case weatherHome(coord: GeoCoordinate)
    case searchCityList
}


