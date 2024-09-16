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
    
    struct Dependency {
        var geocoord: GeoCoordinate
    }
    
    let input: Input
    
    @Published var output: Output
    
    var dependency: Dependency?

    var coordinator: any CoordinatorType
    
    var cancellables: Set<AnyCancellable> = .init()
    
    private let usecase: WeatherUsecase
    
    private var hasFetchedData = false

    init(usecase: WeatherUsecase, dependency: Dependency, coordinator: any CoordinatorType) {
        self.usecase = usecase
        
        self.dependency = dependency
        
        self.coordinator = coordinator
    
        self.input = Input(fetchData: PassthroughSubject<GeoCoordinate, Never>())
        
        self.output = Output()
        
        transform()
        
        defer {
            self.input.fetchData.send(dependency.geocoord)
        }
      
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
        var dailyTemperatures: [String: (max: Double, min: Double, icon: String?)] = [:]
        
        
        for item in response.list {
            var iconFrequency: [String: Int] = [:]
            
            let date = String(item.date.prefix(10))
            let minTemp = item.main.minTemp
            let maxTemp = item.main.maxTemp
            let icon = item.weather.first?.icon
            
            if let icon = item.weather.first?.icon {
                if iconFrequency[date] == nil {
                    iconFrequency[icon] = 1
                } else {
                    iconFrequency[icon]! += 1
                }
            }
            
            if dailyTemperatures[date] == nil {
                dailyTemperatures[date] = (max: maxTemp, min: minTemp, icon: icon)
            } else {
                var currentMax = dailyTemperatures[date]!.max
                var currentMin = dailyTemperatures[date]!.min
                var maxIcon = iconFrequency.max(by: { $0.value < $1.value })?.key
                
                currentMax = max(currentMax, maxTemp)
                currentMin = min(currentMin, minTemp)
                
                dailyTemperatures[date] = (max: currentMax, min: currentMin, icon: maxIcon)
            }
        }
        
        let result = dailyTemperatures.map { DailyTemperature(date: $0.key,
                                                              maxTemp: $0.value.max,
                                                              minTemp: $0.value.min, 
                                                              icon: $0.value.icon) }
            .sorted(by: { $0.date < $1.date })

        return result.count > 5 ? Array(result[0 ..< 5]) : result
    }
}
