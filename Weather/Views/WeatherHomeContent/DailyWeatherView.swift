//
//  DailyWeatherView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI

struct DailyWeatherView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue.opacity(0.3))
            
            VStack(alignment: .leading) {
                Text("5일간의 일기예보")
                    .font(.system(size: 12))
                
                Divider()
                
                ForEach(0 ..< 5) { _ in
                    createDailyWeahterView()
                }
            }
            .padding(8)
        }
    }
}

private extension DailyWeatherView {
    func createDailyWeahterView() -> some View {
        
        VStack {
            HStack {
                Text("오늘")
                    .font(.system(size: 12))
                
                Spacer()
                
                Image("01d")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 28)
                
                Spacer()
                
                Text("최소: -7")
                    .font(.system(size: 12))
                    .padding(.trailing, 8)
                
                Text("최대: -7CC")
                    .font(.system(size: 12))
            }
            Divider()
        }
    }
}
