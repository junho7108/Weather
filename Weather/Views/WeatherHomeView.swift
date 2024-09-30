//
//  WeatherHomeView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI

struct WeatherHomeView: View {
    
    @StateObject var viewModel: WeatherHomeViewModel
    
    var body: some View {
        
        ZStack {
            
            Color(.blue.opacity(0.35))
                .ignoresSafeArea()
            
            if viewModel.output.isLoading {
                
                Spacer()
                
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                
                Spacer()
                
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                        SearchView()
                            .environmentObject(viewModel)
                        
                        CityWeatherView()
                            .environmentObject(viewModel)
                        
                        HourlyWeatherView()
                            .environmentObject(viewModel)
                        
                        DailyWeatherView()
                            .environmentObject(viewModel)
                        
                        MapKitView()
                            .environmentObject(viewModel)
                        
                        WeatherDetailsView()
                            .environmentObject(viewModel)
                    }
                }
                .padding()
            }
        }
    }
}
