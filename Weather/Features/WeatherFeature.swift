//
//  WeatherFeature.swift
//  Weather
//
//  Created by Junho Yoon on 9/27/24.
//

import ComposableArchitecture
import Combine

@Reducer
struct WeatherFeature {
    
    struct State: Equatable {
        var isLoading: Bool = false
        
        var cityWeatherState: CityWeatherState = .init()
        var hourlyWeatherState: HourlyWeatherState = .init()
        var mapkitState: MapKitState = .init()
        var dailyWeatherState: DailyWeatherState = .init()
        var weatherDetailState: WeatherDetailState = .init()
    }
    
    enum Action {
        case fetchData(coord: GeoCoordinate)
        case weahterResponse(Result<WeatherResponse, Error>)
        case forecastResponse(Result<ForecaseWeatherResponse, Error>)
    }
    
    @Dependency(\.weatherUsecase) var usecase: WeatherUsecase
    
    var body: some Reducer<State, Action> {
    
        Reduce { state, action in
            switch action {
            case .fetchData(let coord):
                state.isLoading = true
                
                return .concatenate(
                    .run { send in
                        let response = await usecase.fetchWeather(lat: coord.lat,
                                                                  lon: coord.lon)
                        await send(.weahterResponse(response))
                    }, .run { send in
                        let response = await usecase.forecaseWeather(lat: coord.lat,
                                                                     lon: coord.lon)
                        await send(.forecastResponse(response))
                    }
                )
                
            case .weahterResponse(let result):
                switch result {
                case .success(let response):
                    
                    state.cityWeatherState = CityWeatherState(
                        city: response.name,
                        temp: response.main.temp,
                        description: response.weather.first?.description,
                        tempMax: response.main.maxTemp,
                        tempMin: response.main.minTemp
                    )
                    
                    state.mapkitState = MapKitState(coord: response.coord)
                    
                    state.weatherDetailState = WeatherDetailState(
                        humidity: response.main.humidity,
                        clouds: response.clouds.all,
                        windSpeed: response.wind.speed,
                        pressure: response.main.pressure
                    )
                    
                case .failure(let error):
                    print("🟢 weather error \(error.localizedDescription)")
                }
                
                return .none
                
            case .forecastResponse(let result):
                switch result {
                case .success(let response):
                    
                    let hourlyTemps = extractThreeHourlyForecastForTwoDays(with: response)
                    
                    let dailyTemps = getDailyTemperatures(with: response)
                    
                    state.hourlyWeatherState = HourlyWeatherState(threeHourlyForecast: hourlyTemps)
                    
                    state.dailyWeatherState = DailyWeatherState(dailyTempList: dailyTemps)
                  
                    state.isLoading = false
                    
                case .failure(let error):
                    print("🟢 forecast error \(error.localizedDescription)")
                }
               
                return .none
            }
        }
    }
}

private extension WeatherFeature {
    
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
