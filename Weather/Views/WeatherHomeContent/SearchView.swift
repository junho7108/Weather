//
//  SearchView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel: WeatherHomeViewModel
    
    @State var searchText: String = ""
    
    var body: some View {
        
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
    }
}
