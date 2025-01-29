//
//  KullanimKosullariView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI

struct KullanimKosullariView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Kullanım Koşulları")
                    .font(.title)
                    .bold()
                
                Text("Genel Koşullar")
                    .font(.headline)
                Text("Bu uygulamayı kullanarak aşağıdaki koşulları kabul etmiş sayılırsınız. Uygulama, Mersin Üniversitesi öğrencilerine özel olarak tasarlanmıştır ve yalnızca eğitim amaçlı kullanılabilir.")
                
                Text("Kullanıcı Sorumlulukları")
                    .font(.headline)
                Text("Kullanıcılar, uygulamayı amacına uygun şekilde kullanmakla yükümlüdür. Kötüye kullanım durumunda hesap askıya alınabilir veya kalıcı olarak kapatılabilir.")
                
                // Diğer kullanım koşulları maddeleri...
            }
            .padding()
        }
        .navigationTitle("Kullanım Koşulları")
    }
}
