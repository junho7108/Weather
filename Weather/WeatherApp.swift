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
    var body: some Scene {
        WindowGroup {
//            if let jsonData = FileService.shared.loadJSONFromFile(filename: "citylist") {
//                if let cities = FileService.shared.parse(data: jsonData, modelType: [City].self) {
//                   
//                    SearchCitiyView(cities: cities)
//                        .padding()
//                }
//            }
            
            let repository = WeatherRepository()
            let usecase = WeatherUsecase(repository: repository)
            let viewModel = WeatherHomeViewModel(usecase: usecase)
            
            WeatherHomeView(viewModel: viewModel)
                .onAppear {
                    viewModel.input.fetchData.send(GeoCoordinate(lat: 36.783611, lon: 127.004173))
                }
        }
    }
}
