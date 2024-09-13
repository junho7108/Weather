//
//  ContentView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                SearchView()
                   
                CityWeatherView()
                   
                HourlyWeatherView()
                
                DailyWeatherView()
                
                MapKitView()
              
               WeatherDetailsView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
