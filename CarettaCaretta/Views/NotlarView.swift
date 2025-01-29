//
//  NotlarView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI

struct NotlarView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(dersNotlari) { ders in
                    DersNotCard(dersNot: ders)
                }
            }
            .navigationTitle("Not Durumu")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    // Örnek ders notları
    let dersNotlari = [
        DersNot(
            dersAdi: "Veri Yapıları",
            vize: 85,
            final: 90,
            ortalama: 88,
            harfNotu: "AA"
        ),
        DersNot(
            dersAdi: "Nesne Yönelimli Programlama",
            vize: 75,
            final: 85,
            ortalama: 81,
            harfNotu: "BA"
        ),
        DersNot(
            dersAdi: "Diferansiyel Denklemler",
            vize: 70,
            final: 75,
            ortalama: 73,
            harfNotu: "BB"
        ),
        // Diğer dersler...
    ]
}
