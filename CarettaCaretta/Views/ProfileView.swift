//
//  ProfileView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI

struct ProfilView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading) {
                            Text("Öğrenci Adı")
                                .font(.headline)
                            Text("20231234567")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Bilgisayar Mühendisliği")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Section("Hesap") {
                    NavigationLink(destination: KisiselBilgilerView()) {
                        Label("Kişisel Bilgiler", systemImage: "person.fill")
                    }
                    NavigationLink(destination: DersProgramiView()) {
                        Label("Ders Programı", systemImage: "calendar")
                    }
                    NavigationLink(destination: TranskriptView()) {
                        Label("Transkript", systemImage: "doc.text.fill")
                    }
                }
                
                Section("Ayarlar") {
                    NavigationLink(destination: BildirimAyarlariView()) {
                        Label("Bildirim Ayarları", systemImage: "bell.fill")
                    }
                    NavigationLink(destination: UygulamaAyarlariView()) {
                        Label("Uygulama Ayarları", systemImage: "gear")
                    }
                }
                
                Section {
                    Button(action: {
                        // Çıkış işlemi
                    }) {
                        Label("Çıkış Yap", systemImage: "arrow.right.square")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Profil")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
