//
//  MapKitView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI
import MapKit

struct MapKitView: View {
    @EnvironmentObject var viewModel: WeatherHomeViewModel
    
    @State private var region: MKCoordinateRegion
    
    init() {
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
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
                        .onReceive(viewModel.$output) { output in
                            if let coord = output.response?.coord {
                                region.center = CLLocationCoordinate2D(latitude: coord.lat,
                                                                       longitude: coord.lon)
                            }
                        }
                }
            }
        }
    }
}
