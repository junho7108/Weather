//
//  CityWeatherView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI

struct CityWeatherView: View {
    @EnvironmentObject var viewModel: WeatherHomeViewModel
    
    var body: some View {
        
        VStack(spacing: 8) {
            if let response = viewModel.output.response {
                Text(response.name)
                    .font(.system(size: 32))
                    .foregroundColor(.black)
                
                Text(response.main.temp.kelvinToCelsiusString())
                    .font(.system(size: 48))
                    .foregroundStyle(.black)
                
                Text(response.weather.first?.main.description ?? "")
                    .font(.system(size: 28))
                
                HStack {
                    Text("최고: \(response.main.maxTemp.kelvinToCelsiusString())")
                        .font(.system(size: 20))
                    
                    Divider()
                        .frame(width: 2)
                        .background(.black)
                    
                    Text("최저: \(response.main.minTemp.kelvinToCelsiusString())")
                        .font(.system(size: 20))
                }
            }
        }
        .fixedSize()
    }
}
