//
//  KampusHaritaView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI
import MapKit

struct KampusHaritaView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 36.7875,  // Mersin Üniversitesi koordinatları
            longitude: 34.5251
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01
        )
    )
    
    var body: some View {
        NavigationStack {
            Map(coordinateRegion: $region, annotationItems: kampusYerleri) { yer in
                MapAnnotation(coordinate: yer.coordinate) {
                    VStack {
                        Image(systemName: yer.icon)
                            .font(.system(size: 24))
                            .foregroundColor(.red)
                        Text(yer.name)
                            .font(.caption)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(4)
                    }
                }
            }
            .navigationTitle("Kampüs Haritası")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Konumu sıfırla
                        region = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: 36.7875,
                                longitude: 34.5251
                            ),
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.01,
                                longitudeDelta: 0.01
                            )
                        )
                    }) {
                        Image(systemName: "location.fill")
                    }
                }
            }
        }
    }
    
    // Kampüsteki önemli yerler
    let kampusYerleri: [KampusYeri] = [
        KampusYeri(
            name: "Rektörlük",
            coordinate: CLLocationCoordinate2D(latitude: 36.7875, longitude: 34.5251),
            icon: "building.columns.fill"
        ),
        KampusYeri(
            name: "Merkezi Kafeterya",
            coordinate: CLLocationCoordinate2D(latitude: 36.7870, longitude: 34.5255),
            icon: "cup.and.saucer.fill"
        ),
        KampusYeri(
            name: "Kütüphane",
            coordinate: CLLocationCoordinate2D(latitude: 36.7880, longitude: 34.5248),
            icon: "books.vertical.fill"
        )
        // Diğer önemli yerler eklenebilir
    ]
}
