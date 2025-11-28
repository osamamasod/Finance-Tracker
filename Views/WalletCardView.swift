
//
//  WalletCardView.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 28.11.2025.
//

import SwiftUI

struct WalletCardView: View {
    let wallet: WalletModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(wallet.name)
                    .font(.headline)
                    .foregroundColor(.buttonTextColor)
                Text("\(wallet.balance, specifier: "%.2f") \(wallet.currency)")
                    .font(.subheadline)
                    .foregroundColor(.buttonTextColor.opacity(0.85))
            }
            Spacer()
            Image(systemName: "creditcard.fill")
                .font(.title)
                .foregroundColor(.buttonTextColor.opacity(0.8))
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 150)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.mainColor, Color.mainColor.opacity(0.85)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 5)
    }
}

#Preview {
    WalletCardView(wallet: WalletModel(id: UUID().uuidString, name: "Cash Wallet", balance: 1500.00, currency: "USD"))
        .padding()
        .previewLayout(.sizeThatFits)
}
