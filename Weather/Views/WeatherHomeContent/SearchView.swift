//
//  SearchView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchState: Equatable {
    var searchText: String = "search"
}

enum SearchAction {
    case didTapSearch
}

struct SearchView: View {
  
    let store: Store<SearchState, SearchAction>
    
    @State private var showSearchCityView = false
  
    var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            GeometryReader { geometry in
                       Button(action: {
                           store.send(.didTapSearch)
                       }) {
                           
                           Image(systemName: "magnifyingglass")
                               .foregroundColor(.gray)
                               .padding(.leading, 10)
                           
                           HStack(alignment: .center) {
                               Text(viewStore.searchText)
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
}
