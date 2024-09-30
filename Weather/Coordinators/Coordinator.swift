//
//  Coordinator.swift
//  Weather
//
//  Created by Junho Yoon on 9/28/24.
//

import ComposableArchitecture
import TCACoordinators

@Reducer
struct Coordinator {
    @ObservableState
    struct State: Equatable {
        var routes: [Route<Screen.State>] = [.root(.weatherHome(.init()),
                                                   embedInNavigationView: true)]
    }
    
    enum Action {
        case router(IndexedRouterActionOf<Screen>)
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce<State, Action> { state, action in
           
            switch action {
            case .router(.routeAction(_, action: .weatherHome(.searchAction(.didTapSearch)))):
                state.routes.push(.cityList(.init()))
                return .none
            
            case .router(.routeAction(let id, action: .cityList(.didTap(let city)))):
                state.routes.goBack()
                return .send(.router(.routeAction(id: id - 1, action: .weatherHome(.fetchData(coord: city.coord)))))
                
            default:
                break
            }
            
            return .none
        }
        .forEachRoute(\.routes, action: \.router)
    }
}
