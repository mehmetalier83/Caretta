//
//  AnaSayfaView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//

import SwiftUI

struct AnaSayfaView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    NavigationLink(destination: YemekhaneView()) {
                        MenuKart(
                            baslik: "Yemekhane",
                            icon: "fork.knife",
                            renk: .blue
                        )
                    }
                    
                    NavigationLink(destination: RingView()) {
                        MenuKart(
                            baslik: "Ring Saatleri",
                            icon: "bus.fill",
                            renk: .green
                        )
                    }
                    
                    NavigationLink(destination: KampusHaritaView()) {
                        MenuKart(
                            baslik: "Kampüs Haritası",
                            icon: "map.fill",
                            renk: .orange
                        )
                    }
                    
                    NavigationLink(destination: KutuphaneView()) {
                        MenuKart(
                            baslik: "Kütüphane",
                            icon: "books.vertical.fill",
                            renk: .purple
                        )
                    }
                    
                    NavigationLink(destination: AkademikTakvimView()) {
                        MenuKart(
                            baslik: "Akademik Takvim",
                            icon: "calendar.badge.clock",
                            renk: .red
                        )
                    }
                    
                    NavigationLink(destination: NotlarView()) {
                        MenuKart(
                            baslik: "Not Durumu",
                            icon: "list.clipboard.fill",
                            renk: .indigo
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Mersin Üniversitesi")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
