//
//  BildirimZamanlariView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI

struct BildirimZamanlariView: View {
    @State private var yemekhaneSaat = Date()
    @State private var ringSaat = Date()
    
    var body: some View {
        List {
            Section(header: Text("Günlük Bildirim Zamanları")) {
                DatePicker("Yemekhane Bildirimi", selection: $yemekhaneSaat, displayedComponents: .hourAndMinute)
                DatePicker("Ring Hatırlatması", selection: $ringSaat, displayedComponents: .hourAndMinute)
            }
        }
        .navigationTitle("Bildirim Zamanları")
    }
}
