//
//  Coordinator.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import SwiftUI

class Coordinator: CoordinatorType {
    
    @Published public var path: NavigationPath = NavigationPath()
    
    var initialScene: AppScene
    
    public init(_ initialScene: AppScene) {
        self.initialScene = initialScene
    }
    
    func buildInitialScene() -> some View {
          return buildScene(scene: initialScene)
      }
    
    func buildScene(scene: AppScene) -> some View {
        switch scene {
        case .weatherHome(let coord):
            
            let repository = WeatherRepository()
            let usecase = WeatherUsecase(repository: repository)
            let dependency = WeatherHomeViewModel.Dependency(geocoord: coord)
            let viewModel = WeatherHomeViewModel(usecase: usecase,
                                                 dependency: dependency,
                                                 coordinator: self)
            
            return AnyView(WeatherHomeView(viewModel: viewModel))

        case .searchCityList:
            let repository = CityListRepository()
            let usecase = CityListUsecase(repository: repository)
            let viewModel = SearchCityViewModel(usecase: usecase, coordinator: self)
            
            return AnyView(SearchCitiyView(viewModel: viewModel))
        }
    }
}
