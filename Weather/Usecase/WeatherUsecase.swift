//
//  WeatherUsecase.swift
//  Weather
//
//  Created by Junho Yoon on 9/14/24.
//

import Foundation
import Combine
import Dependencies

struct WeatherUsecase {
    private let repository: WeatherRepositoryType
    
    init(repository: WeatherRepositoryType) {
        self.repository = repository
    }
    
    func fetchWeather(lat: Double, lon: Double) async -> Result<WeatherResponse, Error> {
        return await repository.fetchWeather(lat: lat, lon: lon)
    }
    
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponse, Error> {
        return repository.fetchWeather(lat: lat, lon: lon)
    }
    
    func forecaseWeather(lat: Double, lon: Double) async -> Result<ForecaseWeatherResponse, Error> {
        return await repository.forecaseWeather(lat: lat, lon: lon)
    }
    
    func forecaseWeather(lat: Double, lon: Double) -> AnyPublisher<ForecaseWeatherResponse, Error> {
        return repository.forecaseWeather(lat: lat, lon: lon)
    }
}

extension WeatherUsecase: DependencyKey {
    static var liveValue: WeatherUsecase = WeatherUsecase(repository: WeatherRepository())
}

extension DependencyValues {
    var weatherUsecase: WeatherUsecase {
        get { self[WeatherUsecase.self] }
        set { self[WeatherUsecase.self] = newValue }
    }
}
