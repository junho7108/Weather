//
//  Screen.swift
//  Weather
//
//  Created by Junho Yoon on 9/28/24.
//

import Foundation
import ComposableArchitecture

@Reducer(state: .equatable)
enum Screen {
    case weatherHome(WeatherFeature)
    case cityList(CityListFeature)
}
