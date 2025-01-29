//
//  BildirimAyarlariView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI

struct BildirimAyarlariView: View {
    @State private var yemekhanebildirim = true
    @State private var duyurubildirim = true
    @State private var etkinlikbildirim = true
    @State private var ringbildirim = true
    @State private var notbildirim = true
    
    var body: some View {
        List {
            Section(header: Text("Bildirim Tercihleri")) {
                Toggle(isOn: $yemekhanebildirim) {
                    Label {
                        VStack(alignment: .leading) {
                            Text("Yemekhane Bildirimleri")
                            Text("Günlük menü bildirimleri")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    } icon: {
                        Image(systemName: "fork.knife")
                            .foregroundColor(.orange)
                    }
                }
                
                Toggle(isOn: $duyurubildirim) {
                    Label {
                        VStack(alignment: .leading) {
                            Text("Duyuru Bildirimleri")
                            Text("Önemli duyurular ve güncellemeler")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    } icon: {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.red)
                    }
                }
                
                Toggle(isOn: $etkinlikbildirim) {
                    Label {
                        VStack(alignment: .leading) {
                            Text("Etkinlik Bildirimleri")
                            Text("Yaklaşan etkinlik hatırlatmaları")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    } icon: {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                    }
                }
                
                Toggle(isOn: $ringbildirim) {
                    Label {
                        VStack(alignment: .leading) {
                            Text("Ring Bildirimleri")
                            Text("Ring saati hatırlatmaları")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    } icon: {
                        Image(systemName: "bus.fill")
                            .foregroundColor(.green)
                    }
                }
                
                Toggle(isOn: $notbildirim) {
                    Label {
                        VStack(alignment: .leading) {
                            Text("Not Bildirimleri")
                            Text("Not güncellemeleri")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    } icon: {
                        Image(systemName: "doc.text.fill")
                            .foregroundColor(.purple)
                    }
                }
            }
            
            Section(footer: Text("Bildirimleri kapatmak bazı önemli güncellemeleri kaçırmanıza neden olabilir.")) {
                NavigationLink(destination: BildirimZamanlariView()) {
                    Label("Bildirim Zamanları", systemImage: "clock.fill")
                }
            }
        }
        .navigationTitle("Bildirim Ayarları")
    }
}
