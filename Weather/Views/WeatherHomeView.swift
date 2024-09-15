//
//  WeatherHomeView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI
import RxSwift

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
                        
                        SearchView(viewModel: viewModel)
                        
                        CityWeatherView(viewModel: viewModel)
                        
                        HourlyWeatherView(viewModel: viewModel)
                        
                        DailyWeatherView(viewModel: viewModel)
                        
                        MapKitView(viewModel: viewModel)
                        
                        WeatherDetailsView(viewModel: viewModel)
                    }
                }
                .padding()
            }
        }
    }
}
