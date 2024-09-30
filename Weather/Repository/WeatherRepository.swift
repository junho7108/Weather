//
//  WeatherRepository.swift
//  Weather
//
//  Created by Junho Yoon on 9/14/24.
//

import Combine

protocol WeatherRepositoryType {
    func fetchWeather(lat: Double, lon: Double) async -> Result<WeatherResponse, Error>
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponse, Error>
    
    func forecaseWeather(lat: Double, lon: Double) async -> Result<ForecaseWeatherResponse, Error>
    func forecaseWeather(lat: Double, lon: Double) -> AnyPublisher<ForecaseWeatherResponse, Error>
}

struct WeatherRepository: WeatherRepositoryType {
    
    func fetchWeather(lat: Double, lon: Double) async -> Result<WeatherResponse, any Error> {
        let path = Const.domain + Const.ApiPath.fetchWeather
        let parameters = [
            "lat": String(lat),
            "lon": String(lon),
            "appid": Const.Key.appid
        ]
        
        return await NetworkService.shared.sendGet(with: path,
                                                   parameters: parameters)
    }
    
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponse, any Error> {
        let path = Const.domain + Const.ApiPath.fetchWeather
        let parameters = [
            "lat": String(lat),
            "lon": String(lon),
            "appid": Const.Key.appid
        ]
        
        return NetworkService.shared.sendGet(with: path, 
                                             parameters: parameters)
    }
    
    func forecaseWeather(lat: Double, lon: Double) async -> Result<ForecaseWeatherResponse, any Error> {
        let path = Const.domain + Const.ApiPath.forecastWeather
        let parameters = [
            "lat": String(lat),
            "lon": String(lon),
            "appid": Const.Key.appid
        ]
        
        return await NetworkService.shared.sendGet(with: path,
                                                   parameters: parameters)
    }
               
    
    func forecaseWeather(lat: Double, lon: Double) -> AnyPublisher<ForecaseWeatherResponse, any Error> {
        let path = Const.domain + Const.ApiPath.forecastWeather
        let parameters = [
            "lat": String(lat),
            "lon": String(lon),
            "appid": Const.Key.appid
        ]
        
        return NetworkService.shared.sendGet(with: path,
                                             parameters: parameters)
    }
}
