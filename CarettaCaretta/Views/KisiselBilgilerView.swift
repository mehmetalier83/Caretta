//
//  KisiselBilgilerView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI
struct KisiselBilgilerView: View {
    var body: some View {
        List {
            Section("Kişisel Bilgiler") {
                BilgiSatiri(baslik: "Ad Soyad", deger: "Mehmet Ali Er")
                BilgiSatiri(baslik: "Öğrenci No", deger: "20231234567")
                BilgiSatiri(baslik: "Fakülte", deger: "Mühendislik Fakültesi")
                BilgiSatiri(baslik: "Bölüm", deger: "Bilgisayar Mühendisliği")
                BilgiSatiri(baslik: "Sınıf", deger: "2. Sınıf")
            }
            
            Section("İletişim Bilgileri") {
                BilgiSatiri(baslik: "E-posta", deger: "m.alier@mersin.edu.tr")
                BilgiSatiri(baslik: "Telefon", deger: "+90 (555) 123 45 67")
                BilgiSatiri(baslik: "Adres", deger: "Mersin/Türkiye")
            }
        }
        .navigationTitle("Kişisel Bilgiler")
    }
}
