//
//  WeatherUsecase.swift
//  Weather
//
//  Created by Junho Yoon on 9/14/24.
//

import Foundation
import Combine

struct WeatherUsecase {
    private let repository: WeatherRepositoryType
    
    init(repository: WeatherRepositoryType) {
        self.repository = repository
    }
    
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponse, Error> {
        return repository.fetchWeather(lat: lat, lon: lon)
    }
}
