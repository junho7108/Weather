//
//  SearchView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI

struct SearchView: View {
  
    @State private var showSearchCityView = false
  
    var body: some View {
        
        GeometryReader { geometry in
                   Button(action: {
//                       viewModel.coordinator.push(.searchCityList)
                      print("Button Tapped")
                   }) {
                       
                       Image(systemName: "magnifyingglass")
                           .foregroundColor(.gray)
                           .padding(.leading, 10)
                       
                       HStack(alignment: .center) {
                           Text("search")
                               .font(.headline)
                               .foregroundColor(Color.gray.opacity(0.7))
                           
                           Spacer()
                       }
                   }
                   .frame(width: geometry.size.width, height: 32)
                   .background(Color(.systemGray6))
                   .cornerRadius(12)
               }
        .frame(height: 40)
    }
}
