//
//  MapKitView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI
import MapKit

struct MapKitView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue.opacity(0.3))
            
            VStack(alignment: .leading) {
                Text("강수량")
                    .font(.system(size: 12))
                    .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 0))
    
                Map {
                    
                }
                .cornerRadius(8)
                .frame(height: 300)
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
            }
        }
    }
}
