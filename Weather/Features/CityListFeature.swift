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
        var cityList: [City]
    }
    
    enum Action {
        case fetchData
        case fetchDataResponse(Result<[City], Error>)
        case didTap(City)
        case textDidChange(String)
    }
    
    @Dependency(\.cityListUsecase) var usecase: CityListUsecase
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchData:
            return .run { send in
                let response = await usecase.fetchCityList()
                await send(.fetchDataResponse(response))
            }
            
        case .fetchDataResponse(let result):
            switch result {
            case .success(let cityList):
                state.cityList = cityList
                
            case .failure(let error):
                print("🟢 cityList Error \(error.localizedDescription)")
                break
            }
            
            return .none
            
            
        case .didTap(let city):
            return .none
            
        case .textDidChange(let text):
            return .none
        }
    }
}
