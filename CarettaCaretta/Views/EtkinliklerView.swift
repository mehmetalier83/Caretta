//
//  EtkinliklerView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI

struct EtkinliklerView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(ornekEtkinlikler) { etkinlik in
                    EtkinlikCard(
                        baslik: etkinlik.baslik,
                        aciklama: etkinlik.aciklama,
                        tarih: etkinlik.tarih,
                        saat: etkinlik.saat,
                        yer: etkinlik.yer
                    )
                }
            }
            .navigationTitle("Etkinlikler")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    let ornekEtkinlikler = [
        Etkinlik(
            baslik: "Kariyer Günleri",
            aciklama: "Teknoloji sektöründen uzmanlarla buluşma",
            tarih: "15.02.2025",
            saat: "14:00",
            yer: "Kongre ve Kültür Merkezi"
        ),
        Etkinlik(
            baslik: "Bahar Şenliği",
            aciklama: "Ünlü sanatçıların katılımıyla büyük konser",
            tarih: "20.04.2025",
            saat: "19:00",
            yer: "Merkez Kampüs Amfi Tiyatro"
        ),
        Etkinlik(
            baslik: "Yapay Zeka Semineri",
            aciklama: "Güncel AI teknolojileri ve gelecek trendleri",
            tarih: "10.03.2025",
            saat: "15:30",
            yer: "Mühendislik Fakültesi Konferans Salonu"
        ),
        Etkinlik(
            baslik: "Spor Turnuvası",
            aciklama: "Fakülteler arası futbol ve voleybol turnuvası",
            tarih: "05.03.2025",
            saat: "10:00",
            yer: "Spor Kompleksi"
        ),
        Etkinlik(
            baslik: "Mezuniyet Töreni",
            aciklama: "2024-2025 Akademik Yılı Mezuniyet Töreni",
            tarih: "30.06.2025",
            saat: "17:00",
            yer: "Merkez Kampüs Stadyum"
        )
    ]
}
