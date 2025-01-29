//
//  Etkinlik.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI

struct Etkinlik: Identifiable {
    let id = UUID()
    let baslik: String
    let aciklama: String
    let tarih: String
    let saat: String
    let yer: String
}
