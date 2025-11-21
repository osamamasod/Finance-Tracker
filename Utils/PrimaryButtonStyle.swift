//
//  PrimaryButtonStyle.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 21.11.2025.
//


import SwiftUI

// MARK: - Primary Button Style
struct PrimaryButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.mainColor)
            .foregroundColor(.buttonTextColor)
            .cornerRadius(14)
            .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 2)
            .padding(.horizontal, 21)
    }
}

extension View {
    func primaryButtonStyle() -> some View {
        self.modifier(PrimaryButtonStyle())
    }
}
