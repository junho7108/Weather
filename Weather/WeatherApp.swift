//
//  WeatherApp.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear() {
                    if let jsonData = FileService.shared.loadJSONFromFile(filename: "citylist") {
                        if let cities = FileService.shared.parse(data: jsonData, modelType: [City].self) {
                           
                        }
                    }
                }
        }
    }
}
