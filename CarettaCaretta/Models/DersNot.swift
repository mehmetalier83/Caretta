//
//  DersNot.swift
//  CarettaCaretta
//
//  Created by Mehmet Ali Er on 29.01.2025.
//
import Foundation

struct DersNot: Identifiable {
    let id = UUID()
    let dersAdi: String
    let vize: Int
    let final: Int
    let ortalama: Int
    let harfNotu: String
}
