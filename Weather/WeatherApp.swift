//
//  WeatherApp.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI
import Combine

@main
struct WeatherApp: App {
    @ObservedObject private var coordinator: Coordinator
    
    init() {
        self.coordinator = Coordinator(.weatherHome(coord: GeoCoordinate(lat: 36.783611,
                                                                         lon: 127.004173)))
    }
    
    var body: some Scene {
        WindowGroup {

            NavigationStack(path: $coordinator.path) {
                coordinator.buildInitialScene()
                    .navigationDestination(for: AppScene.self) { scene in
                        coordinator.buildScene(scene: scene)
                    }
            }
        }
    }
}
