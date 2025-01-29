//
//  ContentView.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//

import SwiftUI
import MapKit

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

struct MenuKart: View {
    @Environment(\.colorScheme) var colorScheme
    let baslik: String
    let icon: String
    let renk: Color
    
    var gradientColors: [Color] {
        switch renk {
        case .blue:
            return colorScheme == .dark ? 
                [.blue.opacity(0.8), .blue.opacity(0.5)] :
                [.blue, .blue.opacity(0.7)]
        case .green:
            return colorScheme == .dark ? 
                [.green.opacity(0.8), .green.opacity(0.5)] :
                [.green, .green.opacity(0.7)]
        case .orange:
            return colorScheme == .dark ? 
                [.orange.opacity(0.8), .orange.opacity(0.5)] :
                [.orange, .orange.opacity(0.7)]
        case .purple:
            return colorScheme == .dark ? 
                [.purple.opacity(0.8), .purple.opacity(0.5)] :
                [.purple, .purple.opacity(0.7)]
        case .red:
            return colorScheme == .dark ? 
                [.red.opacity(0.8), .red.opacity(0.5)] :
                [.red, .red.opacity(0.7)]
        case .indigo:
            return colorScheme == .dark ? 
                [.indigo.opacity(0.8), .indigo.opacity(0.5)] :
                [.indigo, .indigo.opacity(0.7)]
        default:
            return colorScheme == .dark ? 
                [.blue.opacity(0.8), .blue.opacity(0.5)] :
                [.blue, .blue.opacity(0.7)]
        }
    }
    
    var cardBackgroundColor: Color {
        colorScheme == .dark ? Color(.systemGray6) : .white
    }
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(.white)
                .frame(width: 80, height: 80)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: gradientColors),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Text(baslik)
                .font(.system(size: 16, weight: .medium))
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, minHeight: 150)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(cardBackgroundColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: gradientColors),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
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
                        ForEach(-2...2, id: \.self) { offset in
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

struct MenuModel {
    let yemek: String
    let kalori: String
    let fiyat: String
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
           let minute = Int(components[1]) {
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

// DuyurularView'ı güncelliyoruz
struct DuyurularView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(1...5, id: \.self) { _ in
                    DuyuruCard(
                        baslik: "Bahar Dönemi Ders Programı",
                        aciklama: "2024-2025 Bahar Dönemi ders programı açıklanmıştır.",
                        tarih: "01.02.2025",
                        kategori: "Akademik"
                    )
                }
            }
            .navigationTitle("Duyurular")
            .navigationBarTitleDisplayMode(.large)
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

// EtkinliklerView'ı güncelliyoruz
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

struct Etkinlik: Identifiable {
    let id = UUID()
    let baslik: String
    let aciklama: String
    let tarih: String
    let saat: String
    let yer: String
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

// ProfilView'ı güncelliyoruz
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

// Placeholder Views
struct KutuphaneView: View {
    var body: some View {
        Text("Kütüphane")
            .navigationTitle("Kütüphane")
    }
}

struct AkademikTakvimView: View {
    var body: some View {
        Text("Akademik Takvim")
            .navigationTitle("Akademik Takvim")
    }
}

// NotlarView'ı güncelliyoruz
struct NotlarView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(dersNotlari) { ders in
                    DersNotKart(dersNot: ders)
                }
            }
            .navigationTitle("Not Durumu")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    // Örnek ders notları
    let dersNotlari = [
        DersNot(
            dersAdi: "Veri Yapıları",
            vize: 85,
            final: 90,
            ortalama: 88,
            harfNotu: "AA"
        ),
        DersNot(
            dersAdi: "Nesne Yönelimli Programlama",
            vize: 75,
            final: 85,
            ortalama: 81,
            harfNotu: "BA"
        ),
        DersNot(
            dersAdi: "Diferansiyel Denklemler",
            vize: 70,
            final: 75,
            ortalama: 73,
            harfNotu: "BB"
        ),
        // Diğer dersler...
    ]
}

struct DersNot: Identifiable {
    let id = UUID()
    let dersAdi: String
    let vize: Int
    let final: Int
    let ortalama: Int
    let harfNotu: String
}

struct DersNotKart: View {
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

// KampusHaritaView'ı güncelliyoruz
struct KampusHaritaView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 36.7875,  // Mersin Üniversitesi koordinatları
            longitude: 34.5251
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01
        )
    )
    
    var body: some View {
        NavigationStack {
            Map(coordinateRegion: $region, annotationItems: kampusYerleri) { yer in
                MapAnnotation(coordinate: yer.coordinate) {
                    VStack {
                        Image(systemName: yer.icon)
                            .font(.system(size: 24))
                            .foregroundColor(.red)
                        Text(yer.name)
                            .font(.caption)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(4)
                    }
                }
            }
            .navigationTitle("Kampüs Haritası")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Konumu sıfırla
                        region = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: 36.7875,
                                longitude: 34.5251
                            ),
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.01,
                                longitudeDelta: 0.01
                            )
                        )
                    }) {
                        Image(systemName: "location.fill")
                    }
                }
            }
        }
    }
    
    // Kampüsteki önemli yerler
    let kampusYerleri: [KampusYeri] = [
        KampusYeri(
            name: "Rektörlük",
            coordinate: CLLocationCoordinate2D(latitude: 36.7875, longitude: 34.5251),
            icon: "building.columns.fill"
        ),
        KampusYeri(
            name: "Merkezi Kafeterya",
            coordinate: CLLocationCoordinate2D(latitude: 36.7870, longitude: 34.5255),
            icon: "cup.and.saucer.fill"
        ),
        KampusYeri(
            name: "Kütüphane",
            coordinate: CLLocationCoordinate2D(latitude: 36.7880, longitude: 34.5248),
            icon: "books.vertical.fill"
        )
        // Diğer önemli yerler eklenebilir
    ]
}

struct KampusYeri: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let icon: String
}

// ProfilView içindeki NavigationLink destinationlarını güncelliyoruz
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

struct DersProgramiView: View {
    var body: some View {
        List {
            ForEach(gunler, id: \.self) { gun in
                Section(header: Text(gun)) {
                    ForEach(dersProgrami[gun] ?? [], id: \.id) { ders in
                        DersSatiri(ders: ders)
                    }
                }
            }
        }
        .navigationTitle("Ders Programı")
    }
    
    let gunler = ["Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma"]
    
    let dersProgrami: [String: [DersBilgisi]] = [
        "Pazartesi": [
            DersBilgisi(ad: "Veri Yapıları", saat: "09:00 - 10:50", derslik: "B102"),
            DersBilgisi(ad: "Diferansiyel Denklemler", saat: "13:00 - 14:50", derslik: "A204")
        ],
        "Salı": [
            DersBilgisi(ad: "Nesne Yönelimli Programlama", saat: "10:00 - 11:50", derslik: "Lab-1"),
            DersBilgisi(ad: "Fizik II", saat: "14:00 - 15:50", derslik: "C103")
        ],
        "Çarşamba": [
            DersBilgisi(ad: "Lineer Cebir", saat: "09:00 - 10:50", derslik: "A105")
        ],
        "Perşembe": [
            DersBilgisi(ad: "Sayısal Analiz", saat: "13:00 - 14:50", derslik: "B205"),
            DersBilgisi(ad: "Veri Yapıları Lab", saat: "15:00 - 16:50", derslik: "Lab-2")
        ],
        "Cuma": [
            DersBilgisi(ad: "Teknik İngilizce", saat: "10:00 - 11:50", derslik: "D101")
        ]
    ]
}

struct DersBilgisi: Identifiable {
    let id = UUID()
    let ad: String
    let saat: String
    let derslik: String
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

struct TranskriptView: View {
    var body: some View {
        List {
            ForEach(donemler, id: \.self) { donem in
                Section(header: Text(donem)) {
                    ForEach(transkriptBilgileri[donem] ?? [], id: \.id) { ders in
                        TranskriptSatiri(ders: ders)
                    }
                }
            }
            
            Section(header: Text("Genel Bilgiler")) {
                BilgiSatiri(baslik: "Genel Ortalama", deger: "3.42")
                BilgiSatiri(baslik: "Toplam AKTS", deger: "120/240")
                BilgiSatiri(baslik: "Başarı Durumu", deger: "Başarılı")
            }
        }
        .navigationTitle("Transkript")
    }
    
    let donemler = ["2023-2024 Güz", "2023-2024 Bahar"]
    
    let transkriptBilgileri: [String: [TranskriptDers]] = [
        "2023-2024 Güz": [
            TranskriptDers(ad: "Veri Yapıları", harfNotu: "AA", kredi: "6", durum: "Başarılı"),
            TranskriptDers(ad: "Diferansiyel Denklemler", harfNotu: "BA", kredi: "5", durum: "Başarılı"),
            TranskriptDers(ad: "Fizik II", harfNotu: "BB", kredi: "6", durum: "Başarılı")
        ],
        "2023-2024 Bahar": [
            TranskriptDers(ad: "Nesne Yönelimli Programlama", harfNotu: "AA", kredi: "6", durum: "Devam Ediyor"),
            TranskriptDers(ad: "Lineer Cebir", harfNotu: "BA", kredi: "5", durum: "Devam Ediyor"),
            TranskriptDers(ad: "Sayısal Analiz", harfNotu: "-", kredi: "5", durum: "Devam Ediyor")
        ]
    ]
}

struct TranskriptDers: Identifiable {
    let id = UUID()
    let ad: String
    let harfNotu: String
    let kredi: String
    let durum: String
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

// Bildirim Ayarları View'ı
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

// Bildirim Zamanları View'ı
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

// Uygulama Ayarları View'ı
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

// Gizlilik Politikası View'ı
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

// Kullanım Koşulları View'ı
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

#Preview {
    ContentView()
}
