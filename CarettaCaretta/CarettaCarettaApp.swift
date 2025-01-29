//
//  CarettaCarettaApp.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//

import SwiftUI

@main
struct CarettaCarettaApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
