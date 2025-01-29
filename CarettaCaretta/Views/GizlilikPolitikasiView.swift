//
//  GizlilikPolitikasiView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI
struct GizlilikPolitikasiView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Gizlilik Politikası")
                    .font(.title)
                    .bold()
                
                Text("Kişisel Verilerin Korunması")
                    .font(.headline)
                Text("Mersin Üniversitesi Mobil Uygulaması, kullanıcıların gizliliğini korumayı taahhüt eder. Uygulama üzerinden toplanan veriler, yalnızca hizmet kalitesini artırmak ve kullanıcı deneyimini iyileştirmek amacıyla kullanılmaktadır.")
                
                Text("Veri Toplama")
                    .font(.headline)
                Text("Uygulama, kullanıcıların konum bilgisi, cihaz bilgileri ve uygulama kullanım istatistiklerini toplamaktadır. Bu veriler, ring servisi ve kampüs haritası gibi özelliklerin düzgün çalışması için gereklidir.")
                
                // Diğer gizlilik politikası maddeleri...
            }
            .padding()
        }
        .navigationTitle("Gizlilik Politikası")
    }
}
