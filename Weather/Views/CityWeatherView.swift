//
//  CityWeatherView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI

struct CityWeatherView: View {
    var body: some View {
        
        VStack(spacing: 8) {
            Text("서울")
                .font(.system(size: 32))
                .foregroundColor(.black)
            
            Text("-7")
                .font(.system(size: 48))
                .foregroundStyle(.black)
            
            Text("맑음")
                .font(.system(size: 28))
            
            HStack {
                Text("최고: -1")
                    .font(.system(size: 20))
                
                Divider()
                    .frame(width: 2)
                    .background(.black)
                
                Text("최저: -1")
                    .font(.system(size: 20))
            }
        }
        .fixedSize()
    }
}
