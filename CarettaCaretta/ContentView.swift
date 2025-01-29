//
//  ContentView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//

import MapKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AnaSayfaView()
                .tabItem {
                    Label("Ana Sayfa", systemImage: "house.fill")
                }
            
            DuyurularView()
                .tabItem {
                    Label("Duyurular", systemImage: "bell.fill")
                }
            
            EtkinliklerView()
                .tabItem {
                    Label("Etkinlikler", systemImage: "calendar")
                }
            
            ProfilView()
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
        }
        .accentColor(.blue)
    }
}

struct YemekhaneView: View {
    @State private var selectedDate = Date()
    let calendar = Calendar.current
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Küçültülmüş tarih seçici
                    HStack {
                        ForEach(-2 ... 2, id: \.self) { offset in
                            let date = calendar.date(byAdding: .day, value: offset, to: selectedDate) ?? selectedDate
                            GunButonu(date: date, selectedDate: $selectedDate)
                        }
                    }
                    .padding()
                    
                    // Günlük menü
                    VStack(spacing: 15) {
                        ForEach(getMenuForDate(selectedDate), id: \.yemek) { menu in
                            MenuCard(
                                yemek: menu.yemek,
                                kalori: menu.kalori,
                                fiyat: menu.fiyat
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Yemekhane Menüsü")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    // Rastgele menü verisi
    func getMenuForDate(_ date: Date) -> [MenuModel] {
        let yemekler = [
            ("Mercimek Çorbası", "120", "5"),
            ("Ezogelin Çorbası", "130", "5"),
            ("Tavuk Sote", "320", "25"),
            ("Karnıyarık", "280", "20"),
            ("İzmir Köfte", "350", "25"),
            ("Etli Nohut", "300", "20"),
            ("Pirinç Pilavı", "250", "10"),
            ("Bulgur Pilavı", "220", "10"),
            ("Makarna", "300", "10"),
            ("Cacık", "100", "5"),
            ("Ayran", "80", "3"),
            ("Kemalpaşa Tatlısı", "200", "10"),
            ("Sütlaç", "220", "10"),
            ("Meyve", "60", "5")
        ]
        
        // Günün menüsü için rastgele 5 yemek seç
        let shuffled = yemekler.shuffled()
        return Array(shuffled.prefix(5)).map { yemek in
            MenuModel(yemek: yemek.0, kalori: "\(yemek.1) kcal", fiyat: "\(yemek.2)₺")
        }
    }
}

struct MenuCard: View {
    @Environment(\.colorScheme) var colorScheme
    let yemek: String
    let kalori: String
    let fiyat: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(yemek)
                    .font(.headline)
                HStack {
                    Text(kalori)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("•")
                        .foregroundColor(.gray)
                    Text(fiyat)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            Spacer()
            Image(systemName: "info.circle")
                .foregroundColor(.blue)
        }
        .padding()
        .background(colorScheme == .dark ? Color(.systemGray6) : .white)
        .cornerRadius(10)
        .shadow(radius: colorScheme == .dark ? 0 : 1)
    }
}

// RingView'ı güncelliyoruz
struct RingView: View {
    @State private var currentTime = Date()
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Çiftlikköy -> Merkez Kampüs")) {
                    ForEach(getRingSaatleri(yon: .gidis), id: \.saat) { ring in
                        RingSaatiRow(
                            kalkis: ring.kalkis,
                            varis: ring.varis,
                            saat: ring.saat,
                            durum: ring.getDurum(currentTime: currentTime)
                        )
                    }
                }
                
                Section(header: Text("Merkez Kampüs -> Çiftlikköy")) {
                    ForEach(getRingSaatleri(yon: .donus), id: \.saat) { ring in
                        RingSaatiRow(
                            kalkis: ring.kalkis,
                            varis: ring.varis,
                            saat: ring.saat,
                            durum: ring.getDurum(currentTime: currentTime)
                        )
                    }
                }
            }
            .navigationTitle("Ring Saatleri")
            .navigationBarTitleDisplayMode(.large)
            .onReceive(timer) { time in
                currentTime = time
            }
        }
    }
    
    enum RingYon {
        case gidis, donus
    }
    
    func getRingSaatleri(yon: RingYon) -> [RingSaati] {
        let saatler = yon == .gidis ? [
            "07:30", "08:00", "08:30", "09:00", "09:30",
            "10:00", "10:30", "11:00", "11:30", "12:00",
            "12:30", "13:00", "13:30", "14:00", "14:30",
            "15:00", "15:30", "16:00", "16:30", "17:00",
            "17:30", "18:00", "18:30", "19:00", "19:30"
        ] : [
            "07:45", "08:15", "08:45", "09:15", "09:45",
            "10:15", "10:45", "11:15", "11:45", "12:15",
            "12:45", "13:15", "13:45", "14:15", "14:45",
            "15:15", "15:45", "16:15", "16:45", "17:15",
            "17:45", "18:15", "18:45", "19:15", "19:45"
        ]
        
        return saatler.map { saat in
            RingSaati(
                kalkis: yon == .gidis ? "Çiftlikköy" : "Merkez Kampüs",
                varis: yon == .gidis ? "Merkez Kampüs" : "Çiftlikköy",
                saat: saat
            )
        }
    }
}

struct RingSaati: Identifiable {
    let id = UUID()
    let kalkis: String
    let varis: String
    let saat: String
    
    enum Durum {
        case gecmis
        case yaklasan
        case gelecek
    }
    
    func getDurum(currentTime: Date) -> Durum {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let currentTimeString = formatter.string(from: currentTime)
        
        // Saat karşılaştırması için string'leri dakikaya çevirelim
        let currentMinutes = timeToMinutes(currentTimeString)
        let ringMinutes = timeToMinutes(saat)
        
        let fark = ringMinutes - currentMinutes
        
        if fark < 0 {
            return .gecmis
        } else if fark <= 30 { // 30 dakika veya daha az kaldıysa
            return .yaklasan
        } else {
            return .gelecek
        }
    }
    
    private func timeToMinutes(_ time: String) -> Int {
        let components = time.split(separator: ":")
        if components.count == 2,
           let hour = Int(components[0]),
           let minute = Int(components[1])
        {
            return hour * 60 + minute
        }
        return 0
    }
}

struct RingSaatiRow: View {
    let kalkis: String
    let varis: String
    let saat: String
    let durum: RingSaati.Durum
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(kalkis)
                Image(systemName: "arrow.right")
                Text(varis)
            }
            .foregroundColor(durum == .gecmis ? .gray : .primary)
            
            HStack {
                Text(saat)
                    .font(.headline)
                    .foregroundColor(durumRengi)
                
                if durum == .yaklasan {
                    Text("(Yaklaşıyor)")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
        }
        .padding(.vertical, 4)
    }
    
    var durumRengi: Color {
        switch durum {
        case .gecmis:
            return .red
        case .yaklasan:
            return .green
        case .gelecek:
            return .primary
        }
    }
}

struct DuyuruCard: View {
    @Environment(\.colorScheme) var colorScheme
    let baslik: String
    let aciklama: String
    let tarih: String
    let kategori: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(kategori)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(8)
            
            Text(baslik)
                .font(.headline)
            
            Text(aciklama)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(tarih)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(colorScheme == .dark ? Color(.systemGray6) : .white)
        .cornerRadius(10)
        .shadow(radius: colorScheme == .dark ? 0 : 1)
    }
}

struct EtkinlikCard: View {
    @Environment(\.colorScheme) var colorScheme
    let baslik: String
    let aciklama: String
    let tarih: String
    let saat: String
    let yer: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(baslik)
                .font(.headline)
            
            Text(aciklama)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                Image(systemName: "calendar")
                Text(tarih)
                
                Image(systemName: "clock")
                    .padding(.leading, 8)
                Text(saat)
            }
            .font(.caption)
            .foregroundColor(.blue)
            
            HStack {
                Image(systemName: "mappin.circle.fill")
                Text(yer)
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding()
        .background(colorScheme == .dark ? Color(.systemGray6) : .white)
        .cornerRadius(10)
        .shadow(radius: colorScheme == .dark ? 0 : 1)
    }
}

struct DersNotCard: View {
    @Environment(\.colorScheme) var colorScheme
    let dersNot: DersNot
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(dersNot.dersAdi)
                .font(.headline)
            
            HStack {
                NotBilgisi(baslik: "Vize", not: dersNot.vize)
                Spacer()
                NotBilgisi(baslik: "Final", not: dersNot.final)
                Spacer()
                NotBilgisi(baslik: "Ortalama", not: dersNot.ortalama)
                Spacer()
                VStack {
                    Text("Harf Notu")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(dersNot.harfNotu)
                        .font(.title3)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }
            }
        }
        .padding()
        .background(colorScheme == .dark ? Color(.systemGray6) : .white)
        .cornerRadius(10)
        .shadow(radius: colorScheme == .dark ? 0 : 1)
    }
}

struct NotBilgisi: View {
    let baslik: String
    let not: Int
    
    var body: some View {
        VStack {
            Text(baslik)
                .font(.caption)
                .foregroundColor(.gray)
            Text("\(not)")
                .font(.title3)
                .foregroundColor(.primary)
        }
    }
}

// Yeni gün butonu view'ı
struct GunButonu: View {
    let date: Date
    @Binding var selectedDate: Date
    
    var body: some View {
        let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
        
        Button(action: {
            selectedDate = date
        }) {
            VStack {
                Text(gunAdi(date))
                    .font(.caption)
                Text(gunTarihi(date))
                    .font(.headline)
            }
            .padding(8)
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.blue : Color.clear)
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(10)
        }
    }
    
    private func gunAdi(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    private func gunTarihi(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
}

struct BilgiSatiri: View {
    let baslik: String
    let deger: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(baslik)
                .font(.caption)
                .foregroundColor(.gray)
            Text(deger)
                .font(.body)
        }
    }
}

struct DersSatiri: View {
    let ders: DersBilgisi
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(ders.ad)
                .font(.headline)
            HStack {
                Label(ders.saat, systemImage: "clock")
                Spacer()
                Label(ders.derslik, systemImage: "door.right.hand.closed")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}

struct TranskriptSatiri: View {
    let ders: TranskriptDers
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(ders.ad)
                    .font(.headline)
                Text("Kredi: \(ders.kredi)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(ders.harfNotu)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Text(ders.durum)
                    .font(.caption)
                    .foregroundColor(ders.durum == "Başarılı" ? .green : .orange)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}
