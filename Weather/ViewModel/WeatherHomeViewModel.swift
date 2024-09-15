//
//  WeatherHomeViewModel.swift
//  Weather
//
//  Created by Junho Yoon on 9/14/24.
//

import Combine

final class WeatherHomeViewModel: ViewModelType {
   
    struct Input: DefaultInput {
        var fetchData: PassthroughSubject<Void, Never>
    }
    
    struct Output {
        var response: WeatherResponse? = nil
        
        var humidity: String? = nil
        var clouds: String? = nil
        var wind: String? = nil
        var windSpeed: String? = nil
        var pressure: String? = nil
    }
    
    struct Coordinate: DefaultCoordinate {
        var close: PassthroughSubject<Void, Never>
    }
    
    let input: Input
    @Published var output: Output
    var coordinate: Coordinate
    
    var cancellables: Set<AnyCancellable> = .init()
    
    private let usecase: WeatherUsecase

    init(usecase: WeatherUsecase) {
        self.usecase = usecase
    
        self.input = Input(fetchData: PassthroughSubject<Void, Never>())
        
        self.output = Output()
        
        self.coordinate = Coordinate(close: PassthroughSubject<Void, Never>())
        
        transform()
    }
    
    func transform() {
        input.fetchData
            .flatMap { [unowned self] in
                self.usecase.fetchWeather(lat: 36.783611, lon: 127.004173)
                    .map { $0 as WeatherResponse? }
                    .catch { _ in Just(nil) }
                
            }
            .sink { [weak self] response in
                
                if let res = response {
                    self?.output.response = res
                    self?.output.humidity = "\(res.main.humidity)%"
                    self?.output.clouds = "\(res.clouds.all)%"
                    self?.output.windSpeed = "\(res.wind.speed)m/s"
                    self?.output.pressure = "\(res.main.pressure)hpa"
                }
               
               
            }
            .store(in: &cancellables)
    }
}
