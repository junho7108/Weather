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
    
    @State private var isInitialLoad: Bool = true
   
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
                            
                            SearchView(store: store.scope(state: \.searchState, action: \.searchAction))
                            
                            IfLetStore(store.scope(state: \.cityWeatherState, action: \.never)) { store in
                                CityWeatherView(store: store)
                            }
                              
                            IfLetStore(store.scope(state: \.hourlyWeatherState, action: \.never)) { store in
                                HourlyWeatherView(store: store)
                            }
                                        
                            IfLetStore(store.scope(state: \.dailyWeatherState, action: \.never)) { store in
                                DailyWeatherView(store: store)
                            }
                                  
                            IfLetStore(store.scope(state: \.mapkitState, action: \.never)) { store in
                                MapKitView(store: store)
                            }
                               
                            IfLetStore(store.scope(state: \.weatherDetailState, action: \.never)) { store in
                                WeatherDetailsView(store: store)
                            }
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                if isInitialLoad {
                    let coordinate = GeoCoordinate(lat: 37.5665, lon: 126.978)
                    store.send(.fetchData(coord: coordinate))
                    isInitialLoad = false
                }
            }
        }
    }
}
