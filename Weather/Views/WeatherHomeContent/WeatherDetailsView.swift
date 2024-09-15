//
//  WeatherDetailsView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI

struct WeatherDetailsView: View {
    @ObservedObject var viewModel: WeatherHomeViewModel
    
    enum WeatherAttribute: Int, CaseIterable {
        case humidity, cloudiness, windSpeed, pressure
        
        var title: String {
            switch self {
            case .humidity: return "습도"
            case .cloudiness: return "구름"
            case .windSpeed: return "바람 속도"
            case .pressure: return "기압"
            }
        }
    }

    var body: some View {
        if let response = viewModel.output.response {
            let columns = [
                   GridItem(.flexible()),
                   GridItem(.flexible())
               ]
           
            LazyVGrid(columns: columns) {
                ForEach(0 ..< WeatherAttribute.allCases.count) { index in
                    if let attribute = WeatherAttribute(rawValue: index) {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.blue.opacity(0.3))
                            
                            VStack(alignment: .leading) {
                                Text(attribute.title)
                                    .font(.system(size: 12))
                                
                                Spacer()
  
                                switch attribute {
                                case .humidity:
                                    Text(viewModel.output.humidity ?? "")
                                        .font(.system(size: 24))
                                case .cloudiness:
                                    Text(viewModel.output.clouds ?? "")
                                        .font(.system(size: 24))
                                case .windSpeed:
                                    Text(viewModel.output.windSpeed ?? "")
                                        .font(.system(size: 24))
                                case .pressure:
                                    Text(viewModel.output.pressure ?? "")
                                        .font(.system(size: 24))
                                }
                               
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(height: 140)
                    }
                }
            }
            
        }
    }
}

//MARK: -
