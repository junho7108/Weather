//
//  WeatherHomeViewModel.swift
//  Weather
//
//  Created by Junho Yoon on 9/14/24.
//

import Foundation
import Combine

final class WeatherHomeViewModel: ViewModelType {
    
    struct Input: WeatherInput {
        var fetchData: PassthroughSubject<GeoCoordinate, Never>
    }
    
    struct Output {
        var isLoading: Bool = false
        
        var response: WeatherResponse? = nil
        var forecaseResponse: ForecaseWeatherResponse? = nil
        
        var humidity: String? = nil
        var clouds: String? = nil
        var wind: String? = nil
        var windSpeed: String? = nil
        var pressure: String? = nil
        
        var threeHourlyForecast: [ForecaseWeather]? = nil
        var dailyTempList: [DailyTemperature]? = nil
    }
    
    struct Coordinate: DefaultCoordinate {
        var showSearchList: PassthroughSubject<Void, Never>
        var close: PassthroughSubject<Void, Never>
    }
    
    let input: Input
    @Published var output: Output
    var coordinate: Coordinate
    
    var cancellables: Set<AnyCancellable> = .init()
    
    private let usecase: WeatherUsecase

    init(usecase: WeatherUsecase) {
        self.usecase = usecase
    
        self.input = Input(fetchData: PassthroughSubject<GeoCoordinate, Never>())
        
        self.output = Output()
        
        self.coordinate = Coordinate(showSearchList: PassthroughSubject<Void, Never>(),
                                     close: PassthroughSubject<Void, Never>())
        
        transform()
    }
    
    func transform() {
        
        let fetchData = input.fetchData
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.output.isLoading = true
            })
        
        let weatherPublisher = fetchData
            .flatMap { [unowned self] geoCoord in
                self.usecase.fetchWeather(lat: geoCoord.lat, lon: geoCoord.lon)
                    .map { $0 as WeatherResponse? }
                    .catch { _ in Just(nil) }
            }
        
        let forecastPublisher = fetchData
            .flatMap { [unowned self] geoCoord in
                self.usecase.forecaseWeather(lat: geoCoord.lat, lon: geoCoord.lon)
                    .map { $0 as ForecaseWeatherResponse? }
                    .catch { _ in Just(nil) }
            }
        
        Publishers.CombineLatest(weatherPublisher, forecastPublisher)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.output.isLoading = false
            })
            .sink { [weak self] weatherResponse, forecastResponse in
                guard let self else { return }
                
                if let weather = weatherResponse {
                    self.output.response = weather
                    self.output.humidity = "\(weather.main.humidity)%"
                    self.output.clouds = "\(weather.clouds.all)%"
                    self.output.windSpeed = "\(weather.wind.speed)m/s"
                    self.output.pressure = "\(weather.main.pressure)hpa"
                }
                
                if let forecast = forecastResponse {
                    self.output.forecaseResponse = forecast
                    
                    self.output.threeHourlyForecast = self.extractThreeHourlyForecastForTwoDays(with: forecast)
                    
                    self.output.dailyTempList = getDailyTemperatures(with: forecast)
                }
            }
            .store(in: &cancellables)
    }
}

extension WeatherHomeViewModel {
    func extractThreeHourlyForecastForTwoDays(with response: ForecaseWeatherResponse) -> [ForecaseWeather] {
        return Array(response.list[0 ... 16])
    }
    
    func getDailyTemperatures(with response: ForecaseWeatherResponse) -> [DailyTemperature] {
        var dailyTemperatures: [String: (max: Double, min: Double)] = [:]

        for item in response.list {
            let date = String(item.date.prefix(10))
            let minTemp = item.main.minTemp
            let maxTemp = item.main.maxTemp
            
            if dailyTemperatures[date] == nil {
                dailyTemperatures[date] = (max: maxTemp, min: minTemp)
            } else {
                var currentMax = dailyTemperatures[date]!.max
                var currentMin = dailyTemperatures[date]!.min
                
                currentMax = max(currentMax, maxTemp)
                currentMin = min(currentMin, minTemp)
                
                dailyTemperatures[date] = (max: currentMax, min: currentMin)
            }
        }
        
        let result = dailyTemperatures.map { DailyTemperature(date: $0.key,
                                                              maxTemp: $0.value.max,
                                                              minTemp: $0.value.min) }
            .sorted(by: { $0.date < $1.date })

        return result
    }
}
