//
//  CoordinatorView.swift
//  Weather
//
//  Created by Junho Yoon on 9/28/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

struct CoordinatorView: View {
    let store: StoreOf<Coordinator>
    
    var body: some View {
        TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
            switch screen.case {
            case .weatherHome(let store):
                WeatherHomeView(store: store)
                
            case .cityList(let store):
                SearchCityView(store: store)
            }
        }
    }
}
