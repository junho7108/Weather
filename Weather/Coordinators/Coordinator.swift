//
//  Coordinator.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import SwiftUI

class Coordinator: CoordinatorType {
    
    @Published public var path: NavigationPath = NavigationPath()
    
    private var children: [String: any View] = [:]
    
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
            if let homeView = children[scene.identifier] as? WeatherHomeView {
                homeView.viewModel.input.fetchData.send((coord))
                return AnyView(homeView)
            } else {
                let homeView = createWeatherHomeView(coord: coord)
                children[scene.identifier] = homeView
                return AnyView(homeView)
            }
            
            
        case .searchCityList:
            if let searchCityView = children[scene.identifier] as? SearchCityView {
                return AnyView(searchCityView)
            } else {
                let searchCityView = createSearchCityView()
                children[scene.identifier] = searchCityView
                return AnyView(searchCityView)
            }
        }
    }
}

private extension Coordinator {
    func createWeatherHomeView(coord: GeoCoordinate) -> WeatherHomeView {
        let repository = WeatherRepository()
        let usecase = WeatherUsecase(repository: repository)
        let dependency = WeatherHomeViewModel.Dependency(geocoord: coord)
        let viewModel = WeatherHomeViewModel(usecase: usecase,
                                             dependency: dependency,
                                             coordinator: self)

        viewModel.input.fetchData.send(coord)
        
        return WeatherHomeView(viewModel: viewModel)
    }
    
    private func createSearchCityView() -> SearchCityView {
        let repository = CityListRepository()
        let usecase = CityListUsecase(repository: repository)
        let viewModel = SearchCityViewModel(usecase: usecase, coordinator: self)
        
        return SearchCityView(viewModel: viewModel)
    }
}
