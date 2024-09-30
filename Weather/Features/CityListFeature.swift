//
//  CityListFeature.swift
//  Weather
//
//  Created by Junho Yoon on 9/29/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct CityListFeature {
    
    struct State: Equatable {
        var originCityList: [City]?
        var filteredCityList: [City]?
    }
    
    enum Action {
        case fetchData
        case fetchDataResponse(Result<[City], Error>)
        case didTap(City)
        case textDidChange(String)
    }
    
    @Dependency(\.cityListUsecase) var usecase: CityListUsecase
    
    var body: some Reducer<State, Action> {
        
        Reduce { state, action in
            switch action {
            case .fetchData:
                return .run { send in
                    let response = await usecase.fetchCityList()
                    await send(.fetchDataResponse(response))
                }
                
            case .fetchDataResponse(let result):
                switch result {
                case .success(let cityList):
                    state.originCityList = cityList
                    state.filteredCityList = cityList
                    
                case .failure(let error):
                    print("🔴 cityList Error \(error.localizedDescription)")
                    break
                }
                
                return .none
                
                
            case .didTap:
                return .none
                
            case .textDidChange(let text):
                state.filteredCityList = filterCities(cityList: state.originCityList,
                                                      searchText: text) ?? []
                return .none
            }
        }
    }
}

private extension CityListFeature {
    func filterCities(cityList: [City]?, searchText: String) -> [City]? {
        
        guard let cityList,
              !searchText.isEmpty else { return cityList }
        
        let lowercasedSearchText = searchText.lowercased()
        
        return cityList.filter { city in
            city.name.lowercased().contains(lowercasedSearchText) ||
            city.country.lowercased().contains(lowercasedSearchText)
        }
    }
}
