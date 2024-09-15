//
//  WeatherRepository.swift
//  Weather
//
//  Created by Junho Yoon on 9/14/24.
//

import Combine

protocol WeatherRepositoryType {
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponse, Error>
}

struct WeatherRepository: WeatherRepositoryType {
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
}
