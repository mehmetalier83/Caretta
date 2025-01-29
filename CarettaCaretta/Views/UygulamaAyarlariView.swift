//
//  UygulamaAyarlariView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI

struct UygulamaAyarlariView: View {
    @AppStorage("otomatikGiris") private var otomatikGiris = true
    @AppStorage("konumErisimi") private var konumErisimi = true
    @State private var onbellek: Double = 0
    
    var body: some View {
        List {
            Section(header: Text("Genel")) {
                Toggle(isOn: $otomatikGiris) {
                    Label {
                        VStack(alignment: .leading) {
                            Text("Otomatik Giriş")
                            Text("Uygulamayı açtığında otomatik giriş yap")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    } icon: {
                        Image(systemName: "key.fill")
                            .foregroundColor(.blue)
                    }
                }
                
                Toggle(isOn: $konumErisimi) {
                    Label {
                        VStack(alignment: .leading) {
                            Text("Konum Erişimi")
                            Text("Ring ve kampüs özellikleri için konum erişimi")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    } icon: {
                        Image(systemName: "location.fill")
                            .foregroundColor(.green)
                    }
                }
            }
            
            Section(header: Text("Depolama"), footer: Text("Önbelleği temizlemek bazı içeriklerin yeniden yüklenmesine neden olabilir.")) {
                HStack {
                    Label {
                        Text("Önbellek Boyutu")
                    } icon: {
                        Image(systemName: "internaldrive.fill")
                            .foregroundColor(.orange)
                    }
                    Spacer()
                    Text(String(format: "%.1f MB", onbellek))
                        .foregroundColor(.gray)
                }
                
                Button(action: {
                    // Önbelleği temizle
                    onbellek = 0
                }) {
                    Label("Önbelleği Temizle", systemImage: "trash.fill")
                        .foregroundColor(.red)
                }
            }
            
            Section(header: Text("Hakkında")) {
                HStack {
                    Label("Uygulama Versiyonu", systemImage: "info.circle.fill")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.gray)
                }
                
                NavigationLink(destination: GizlilikPolitikasiView()) {
                    Label("Gizlilik Politikası", systemImage: "hand.raised.fill")
                }
                
                NavigationLink(destination: KullanimKosullariView()) {
                    Label("Kullanım Koşulları", systemImage: "doc.text.fill")
                }
            }
        }
        .navigationTitle("Uygulama Ayarları")
    }
}
