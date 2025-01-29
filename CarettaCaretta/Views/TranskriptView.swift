//
//  TranskriptView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI

struct TranskriptView: View {
    var body: some View {
        List {
            ForEach(donemler, id: \.self) { donem in
                Section(header: Text(donem)) {
                    ForEach(transkriptBilgileri[donem] ?? [], id: \.id) { ders in
                        TranskriptSatiri(ders: ders)
                    }
                }
            }
            
            Section(header: Text("Genel Bilgiler")) {
                BilgiSatiri(baslik: "Genel Ortalama", deger: "3.42")
                BilgiSatiri(baslik: "Toplam AKTS", deger: "120/240")
                BilgiSatiri(baslik: "Başarı Durumu", deger: "Başarılı")
            }
        }
        .navigationTitle("Transkript")
    }
    
    let donemler = ["2023-2024 Güz", "2023-2024 Bahar"]
    
    let transkriptBilgileri: [String: [TranskriptDers]] = [
        "2023-2024 Güz": [
            TranskriptDers(ad: "Veri Yapıları", harfNotu: "AA", kredi: "6", durum: "Başarılı"),
            TranskriptDers(ad: "Diferansiyel Denklemler", harfNotu: "BA", kredi: "5", durum: "Başarılı"),
            TranskriptDers(ad: "Fizik II", harfNotu: "BB", kredi: "6", durum: "Başarılı")
        ],
        "2023-2024 Bahar": [
            TranskriptDers(ad: "Nesne Yönelimli Programlama", harfNotu: "AA", kredi: "6", durum: "Devam Ediyor"),
            TranskriptDers(ad: "Lineer Cebir", harfNotu: "BA", kredi: "5", durum: "Devam Ediyor"),
            TranskriptDers(ad: "Sayısal Analiz", harfNotu: "-", kredi: "5", durum: "Devam Ediyor")
        ]
    ]
}
