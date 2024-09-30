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
            let store = Store(initialState: Coordinator.State()) {
                Coordinator()
            }
            
            CoordinatorView(store: store)
        }
    }
}
