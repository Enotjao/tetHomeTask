//
//  MapView.swift
//  TetHomeTask
//

import SwiftUI
import MapKit

struct MapView: View {
    var selectedCountry: Country
    @State private var region: MKCoordinateRegion
    
    init(selectedCountry: Country) {
        self.selectedCountry = selectedCountry
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: selectedCountry.capitalInfo.latlng?.first ?? 0, longitude: selectedCountry.capitalInfo.latlng?.last ?? 0),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        ))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [selectedCountry]) { country in
            MapMarker(
                coordinate: CLLocationCoordinate2D(
                    latitude: country.capitalInfo.latlng?.first ?? 0,
                    longitude: country.capitalInfo.latlng?.last ?? 0),
                tint: Colors.themeMapMarkerTint)
        }
        .onAppear {
            if let latitude = selectedCountry.capitalInfo.latlng?.first, let longitude = selectedCountry.capitalInfo.latlng?.last {
                region.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
        }
    }
}
