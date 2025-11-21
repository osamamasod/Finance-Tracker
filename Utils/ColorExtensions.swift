//
//  ColorExtensions.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 21.11.2025.
//

import SwiftUI

extension Color {
    static let mainColor = Color(hex: "#52231D")        // Accent: deep brown
    static let pageBackground = Color(hex: "#E0E0E0")   // Soft grey page background
    static let buttonTextColor = Color(hex: "#FFFFFF")  // White text for contrast
    static let headerTextColor = Color(hex: "#000000")  // Black headers
    static let secondaryText = Color(hex: "#555555")    // Subtext grey
    static let dividerGray = Color(hex: "#B0B0B0")      // Divider/graph grey
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        
        self.init(red: r, green: g, blue: b)
    }
}
