//
//  DuyurularView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI

struct DuyurularView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(1...5, id: \.self) { _ in
                    DuyuruCard(
                        baslik: "Bahar Dönemi Ders Programı",
                        aciklama: "2024-2025 Bahar Dönemi ders programı açıklanmıştır.",
                        tarih: "01.02.2025",
                        kategori: "Akademik"
                    )
                }
            }
            .navigationTitle("Duyurular")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
