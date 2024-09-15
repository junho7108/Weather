//
//  MapKitView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI
import MapKit

struct MapKitView: View {
    @StateObject var viewModel: WeatherHomeViewModel
    
    @State private var region: MKCoordinateRegion
    
    init(viewModel: WeatherHomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        
        let initialCoord = CLLocationCoordinate2D(latitude: viewModel.output.response?.coord.lat ?? 0,
                                                  longitude: viewModel.output.response?.coord.lon ?? 0)
        
        _region = State(initialValue: MKCoordinateRegion(
            center: initialCoord,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.5)
        ))
    }
    
    var body: some View {
        if let res = viewModel.output.response {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.blue.opacity(0.3))
                
                VStack(alignment: .leading) {
                    Text("강수량")
                        .font(.system(size: 12))
                        .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 0))
                    
                    Map(coordinateRegion: $region,
                        annotationItems: [res.coord]) { coord in
                        MapPin(coordinate: .init(latitude: coord.lat, longitude: coord.lon), tint: .red)
                    }
                        .cornerRadius(8)
                        .frame(height: 300)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
                }
            }
        }
    }
}
