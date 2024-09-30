//
//  SearchCitiyView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchCityView: View {
    
    let store: StoreOf<CityListFeature>
    
    @State var searchText: String = ""
    
    var body: some View {
        
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                Color(.blue.opacity(0.35))
                    .ignoresSafeArea()
                
                VStack {
                    TextField("search", text: $searchText)
                        .onChange(of: searchText) { newValue, _  in
                            viewStore.send(.textDidChange(newValue))
                        }
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
                    
                    if let cityList = viewStore.filteredCityList, !cityList.isEmpty {
                        
                        List(cityList) { city in
                            Button {
                                viewStore.send(.didTap(city))
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
                        .cornerRadius(12)
                        .listStyle(.plain)
                        .scrollIndicators(.hidden)
                    } else {
                        Text("검색 된 도시정보가 없습니다.")
                            .padding(.top)
                            .foregroundColor(Color.black.opacity(0.8))
                            .font(.system(size: 16))
                        
                        Spacer()
                    }
                }
                .background(Color.clear)
                .padding([.top, .leading, .trailing])
            }
            .background(Color.clear)
        }
        .onAppear {
            store.send(.fetchData)
        }
    }
}
