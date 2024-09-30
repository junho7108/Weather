//
//  WeatherHomeView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI
import ComposableArchitecture

struct WeatherHomeView: View {
    
    var store: StoreOf<WeatherFeature>
    
    var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            ZStack {
                
                Color(.blue.opacity(0.35))
                    .ignoresSafeArea()
                
                if viewStore.state.isLoading {
                    
                    Spacer()
                    
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                    
                    Spacer()
                    
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            
                            SearchView()
                        
                            CityWeatherView(
                                store: store.scope(state: \.cityWeatherState,
                                                   action: \.never)
                            )
                               
                            HourlyWeatherView(
                                store: store.scope(state: \.hourlyWeatherState,
                                                   action: \.never)
                            )
                               
                            DailyWeatherView(
                                store: store.scope(state: \.dailyWeatherState,
                                                   action: \.never)
                            )
                               
                            MapKitView(
                                store: store.scope(state: \.mapkitState,
                                                   action: \.never)
                            )
                               
                            WeatherDetailsView(
                                store: store.scope(state: \.weatherDetailState,
                                                   action: \.never)
                            )
                              
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                let coordinate = GeoCoordinate(lat: 37.5665, lon: 126.978)
                store.send(.fetchData(coord: coordinate))
            }
        }
    }
}
