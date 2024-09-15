//
//  SearchCitiyView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI

struct SearchCitiyView: View {
    
    @StateObject var viewModel: SearchCityViewModel
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            Color(.blue.opacity(0.35))
                .ignoresSafeArea()
            
            VStack {
                TextField("search", text: $searchText)
                    .padding(.leading, 60)
                    .frame(height: 40)
                    .background(Color(.systemGray6))
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.leading, 10)
                            
                            Spacer()
                        }
                    )
                    .cornerRadius(12)
                    .padding(.bottom)
                
                if let cityList = viewModel.output.cityList {
                    
                        List(cityList) { city in
                            
                            Button {
                                withAnimation(nil) {
                                    viewModel.coordinator.pop()
//                                    viewModel.coordinator.push(.weatherHome(coord: city.coord))
                                }
                                
                                
                            } label: {
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(city.name)
                                        .font(.system(size: 16))
                                        .bold()
                                    
                                    Text(city.country)
                                        .font(.system(size: 12))
                                }
                            }
                            
                        }
                        .listRowBackground(Color.blue.opacity(0.4))
                        .background(Color.blue.opacity(0.4))
                        .listStyle(.plain)
                        .scrollIndicators(.hidden)
                }
            }
            .padding([.top, .leading, .trailing])
            .background(.clear)
        }
    }
}
