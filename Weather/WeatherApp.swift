//
//  WeatherApp.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI
import Combine
import ComposableArchitecture

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let store = Store(initialState: WeatherFeature.State()) {
                WeatherFeature()
                    ._printChanges()
            }
            WeatherHomeView(store: store)
            
//            CoordinatorView(store: StoreOf<Coordinator>(
//                initialState: Coordinator.State(routes: []),
//                reducer: { Coordinator()})
//            )
        }
    }
}
