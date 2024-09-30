//
//  CityListFeature.swift
//  Weather
//
//  Created by Junho Yoon on 9/29/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct CityListFeature {
    
    struct State: Equatable {
        var cityList: [City]
    }
    
    enum Action: Equatable {
        case didTap(City)
        case textDidChange(String)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .didTap(let city):
            return .none
            
        case .textDidChange(let text):
            return .none
        }
    }
}
