//
//  Coordinator.swift
//  Weather
//
//  Created by Junho Yoon on 9/28/24.
//

import ComposableArchitecture
import TCACoordinators

//@Reducer
//struct Coordinator {
//    @ObservableState
//    struct State: Equatable {
//        var routes: [Route<Screen.State>]
//    }
//    
//    enum Action {
//        case router(IndexedRouterActionOf<Screen>)
//    }
//    
//    var body: some ReducerOf<Self> {
//        Reduce<State, Action> { state, action in
//            switch action {
//            case .router(.routeAction(_, action: .home(.fetchData(let coord)))):
//                state.routes.presentSheet(.home(WeatherFeature.State()))
//                
//            
//            default:
//                break
//            }
//            
//            return .none
//        }
//        .forEachRoute(\.routes, action: \.router)
//    }
//}
