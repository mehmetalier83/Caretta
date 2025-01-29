//
//  DersProgramiView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI

struct DersProgramiView: View {
    var body: some View {
        List {
            ForEach(gunler, id: \.self) { gun in
                Section(header: Text(gun)) {
                    ForEach(dersProgrami[gun] ?? [], id: \.id) { ders in
                        DersSatiri(ders: ders)
                    }
                }
            }
        }
        .navigationTitle("Ders Programı")
    }
    
    let gunler = ["Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma"]
    
    let dersProgrami: [String: [DersBilgisi]] = [
        "Pazartesi": [
            DersBilgisi(ad: "Veri Yapıları", saat: "09:00 - 10:50", derslik: "B102"),
            DersBilgisi(ad: "Diferansiyel Denklemler", saat: "13:00 - 14:50", derslik: "A204")
        ],
        "Salı": [
            DersBilgisi(ad: "Nesne Yönelimli Programlama", saat: "10:00 - 11:50", derslik: "Lab-1"),
            DersBilgisi(ad: "Fizik II", saat: "14:00 - 15:50", derslik: "C103")
        ],
        "Çarşamba": [
            DersBilgisi(ad: "Lineer Cebir", saat: "09:00 - 10:50", derslik: "A105")
        ],
        "Perşembe": [
            DersBilgisi(ad: "Sayısal Analiz", saat: "13:00 - 14:50", derslik: "B205"),
            DersBilgisi(ad: "Veri Yapıları Lab", saat: "15:00 - 16:50", derslik: "Lab-2")
        ],
        "Cuma": [
            DersBilgisi(ad: "Teknik İngilizce", saat: "10:00 - 11:50", derslik: "D101")
        ]
    ]
}
