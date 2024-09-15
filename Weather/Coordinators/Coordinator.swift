//
//  Coordinator.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import SwiftUI

class Coordinator: CoordinatorTransitable {
    @Published public var path: NavigationPath = NavigationPath()
    
    private let initialScene: AppScene
    
    public init(_ initialScene: AppScene) {
        self.initialScene = initialScene
    }
    
    func buildInitialScene() -> some View {
          return buildScene(scene: initialScene)
      }
    
    
    func buildScene(scene: AppScene) -> some View {
        print("buildScene \(scene)")
        switch scene {
        case .weatherHome(let coord):
            
            let repository = WeatherRepository()
            let usecase = WeatherUsecase(repository: repository)
            let viewModel = WeatherHomeViewModel(usecase: usecase, coordinator: self)

            return AnyView(WeatherHomeView(viewModel: viewModel)
                .onAppear {
                    viewModel.input.fetchData.send(GeoCoordinate(lat: coord.lat, lon: coord.lon))
                })
                
        case .searchCityList:
            let repository = CityListRepository()
            let usecase = CityListUsecase(repository: repository)
            let viewModel = SearchCityViewModel(usecase: usecase, coordinator: self)
            return AnyView(SearchCitiyView(viewModel: viewModel)
                .onAppear {
                    viewModel.input.fetchData.send(())
                })
            
        }
    }
}
