//
//  MapKitView.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import SwiftUI
import MapKit
import ComposableArchitecture

struct MapKitState: Equatable {
    var coord: GeoCoordinate
}

struct MapKitView: View {
    
    let store: Store<MapKitState, Never>
    
    @State private var region: MKCoordinateRegion = .init(center: .init(latitude: 37.5665,
                                                                        longitude: 126.978),
                                                          span: .init(latitudeDelta: 0.05, longitudeDelta: 0.5))
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.blue.opacity(0.3))
                
                VStack(alignment: .leading) {
                    Text("강수량")
                        .font(.system(size: 12))
                        .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 0))
                    
                    Map(coordinateRegion: $region,
                        annotationItems: [viewStore.coord]) { coord in
                        MapPin(coordinate: .init(latitude: coord.lat, longitude: coord.lon), tint: .red)
                    }
                        .cornerRadius(8)
                        .frame(height: 300)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
                }
            }
            .onAppear {
                region.center = CLLocationCoordinate2D(latitude: viewStore.coord.lat,
                                                       longitude: viewStore.coord.lon)
            }
        }
    }
}
