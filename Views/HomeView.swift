//
//  HomeView.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 28.11.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var showCreateWallet = false
    @State private var showCurrencyPicker = false
    @State private var selectedWalletIndex = 0

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    // MARK: - Header
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Dashboard")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.black)
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)

                    totalBalanceSection

                    WalletCardViewCarousel()

                    addWalletButton
                }
                .padding(.bottom)
            }
            .background(Color(.systemGray6).ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }

    private var totalBalanceSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Financial Overview")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                
                Button {
                    showCurrencyPicker.toggle()
                } label: {
                    HStack(spacing: 6) {
                        Text("USD")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                        Image(systemName: "chevron.down")
                            .font(.caption2)
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(6)
                }
            }
            
            VStack(spacing: 12) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Total Balance")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("0.00")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.black)
                            Text("USD")
                                .font(.title3)
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                    }
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Active Wallets")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("0")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }

    private func WalletCardViewCarousel() -> some View {
        TabView {
            ForEach(0..<3) { _ in
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .frame(height: 220)
                    .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                    .padding(.horizontal, 20)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 220)
    }

    private var addWalletButton: some View {
        Button {
            showCreateWallet.toggle()
        } label: {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Add Wallet")
            }
        }
        .primaryButtonStyle()
    }
}

#Preview {
    HomeView()
}
