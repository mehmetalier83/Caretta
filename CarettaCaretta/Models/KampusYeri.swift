//
//  KampusYeri.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import Foundation
import MapKit

struct KampusYeri: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let icon: String
}
