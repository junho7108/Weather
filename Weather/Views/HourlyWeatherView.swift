    //
    //  HourlyWeatherView.swift
    //  Weather
    //
    //  Created by Junho Yoon on 9/13/24.
    //

    import SwiftUI

    struct HourlyWeatherView: View {
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.blue.opacity(0.3))
                
                VStack(alignment: .leading) {
                    Text("돌풍의 풍속은 최대 4m/s입니다.")
                        .font(.system(size: 12))
                        .padding(.leading, 8)
                    
                    Divider()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0 ..< 10) { _ in
                                createHourlyWeahterView(icon: "01d", hour: "오전 11시", temp: "-7")
                            }
                        }
                    }
                }
                .padding(8)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }

    private extension HourlyWeatherView {
        func createHourlyWeahterView(icon: String, hour: String, temp: String) -> some View {
            VStack {
                Text(hour)
                    .font(.system(size: 12))
                
                Image("01d")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
                
                Text(temp)
                    .font(.system(size: 12))
            }
        }
    }
