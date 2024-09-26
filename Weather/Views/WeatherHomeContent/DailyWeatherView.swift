//
//  DailyWeatherView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI

struct DailyWeatherView: View {
    
    @EnvironmentObject var viewModel: WeatherHomeViewModel
    
    var body: some View {
        if let dailyTemps = viewModel.output.dailyTempList {
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.blue.opacity(0.3))
                
                VStack(alignment: .leading) {
                    Text("5일간의 일기예보")
                        .font(.system(size: 12))
                    
                    Divider()
                    
                    ForEach(dailyTemps) { dailyTemp in
                        createDailyWeahterView(icon: dailyTemp.icon,
                                               date: dailyTemp.date,
                                               maxTemp: dailyTemp.maxTemp,
                                               minTemp: dailyTemp.minTemp)
                    }
                }
                .padding(8)
                
            }
        }
    }
}

private extension DailyWeatherView {
    func createDailyWeahterView(icon: String?, date: String, maxTemp: Double, minTemp: Double) -> some View {
        
        VStack {
            HStack {
                Text(date)
                    .font(.system(size: 12))
                
                Spacer()
                
                Image(icon ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 28)
                
                Spacer()
                
                Text("최소: \(minTemp.kelvinToCelsiusString())")
                    .font(.system(size: 12))
                    .padding(.trailing, 8)
                
                Text("최대: \(maxTemp.kelvinToCelsiusString())")
                    .font(.system(size: 12))
            }
            Divider()
        }
    }
}
