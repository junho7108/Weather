//
//  SearchCitiyView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI

struct SearchCitiyView: View {
    @State var cities: [City]
    
    var body: some View {
      
        VStack {
            SearchView()
                .padding(.bottom)
            
            List(cities) { city in
                VStack(alignment: .leading, spacing: 8) {
                    Text(city.name)
                        .font(.system(size: 16))
                        .bold()
                    
                    Text(city.country)
                        .font(.system(size: 12))
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
        }
    }
}
