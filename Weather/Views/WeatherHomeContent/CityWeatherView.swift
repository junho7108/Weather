//
//  CityWeatherView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI
import ComposableArchitecture

struct CityWeatherState: Equatable {
    var city: String
    var temp: Double
    var description: String?
    var tempMax: Double
    var tempMin: Double
}

struct CityWeatherView: View {
    
    let store: Store<CityWeatherState, Never>
    
    var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 8) {
                
                Text(viewStore.city)
                    .font(.system(size: 32))
                    .foregroundColor(.black)
                
                Text(viewStore.temp.kelvinToCelsiusString())
                    .font(.system(size: 48))
                    .foregroundStyle(.black)
                
                if let description = viewStore.description {
                    Text(description)
                        .font(.system(size: 28))
                }
              
                HStack {
                    Text("최고: \(viewStore.tempMax.kelvinToCelsiusString())")
                        .font(.system(size: 20))
                    
                    Divider()
                        .frame(width: 2)
                        .background(.black)
                    
                    Text("최저: \(viewStore.tempMin.kelvinToCelsiusString())")
                        .font(.system(size: 20))
                }
            }
        }
        .fixedSize()
    }
}
