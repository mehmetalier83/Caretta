//
//  MenuKart.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import SwiftUI

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
