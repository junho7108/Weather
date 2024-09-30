//
//  HourlyWeatherView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI

struct HourlyWeatherView: View,
                          DateFormatterProtocol {
    
    @EnvironmentObject var viewModel: WeatherHomeViewModel
    
    var body: some View {
        if let list = viewModel.output.threeHourlyForecast {
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.blue.opacity(0.3))
                
                VStack(alignment: .leading) {
                    Text("3시간 간격으로 2일간의 기온 표시")
                        .font(.system(size: 12))
                        .padding(.leading, 8)
                    
                    Divider()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(list) { forecast in
                                createHourlyWeahterView(icon: forecast.weather.first!.icon,
                                                        hour: formatDateString(forecast.date) ?? forecast.date,
                                                        temp: forecast.main.temp.kelvinToCelsiusString())
                            }
                        }
                    }
                }
                .padding(8)
            }
            .fixedSize(horizontal: false, vertical: true)
            
        }
    }
}

private extension HourlyWeatherView {
    func createHourlyWeahterView(icon: String, hour: String, temp: String) -> some View {
        VStack {
            Text(hour)
                .font(.system(size: 12))
            
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 32)
            
            Text(temp)
                .font(.system(size: 12))
        }
        .padding(.trailing, 4)
    }
}
