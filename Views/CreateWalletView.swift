//
//  CreateWalletView.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 25.11.2025.
//

import SwiftUI

struct CreateWalletView: View {
    var body: some View {
        ZStack {
            Color.pageBackground.ignoresSafeArea()

            VStack(spacing: 0) {
               
                // Header Section
                VStack(spacing: 16) {
                    Image(systemName: "creditcard.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.mainColor)
                    
                    VStack(spacing: 8) {
                        Text("Create Your Wallet")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.headerTextColor)
                            .multilineTextAlignment(.center)

                        Text("Add your wallet to start tracking your income.")
                            .font(.system(size: 16))
                            .foregroundColor(.secondaryText)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                    }
                }
                .padding(.top, 40)
                .padding(.bottom, 40)
                .padding(.horizontal, 32)

                // Form Card Section
                VStack(spacing: 24) {
                    inputField(title: "Wallet Name") {
                        TextField("e.g., Personal Wallet", text: .constant(""))
                    }

                    inputField(title: "Currency") {
                        HStack {
                            Text("Select Currency")
                                .foregroundColor(.secondaryText)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondaryText)
                        }
                    }

                    inputField(title: "Wallet Type") {
                        HStack {
                            Text("Select Type")
                                .foregroundColor(.secondaryText)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondaryText)
                        }
                    }

                    inputField(title: "Starting Balance") {
                        TextField("0.00", text: .constant(""))
                    }
                }
                .padding(.vertical, 32)
                .padding(.horizontal, 24)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 8)
                .padding(.horizontal, 24)
                .padding(.bottom, 40)

                // Buttons Section
                VStack(spacing: 16) {
                    Button {
                        // Placeholder action
                    } label: {
                        Text("Create Wallet")
                            .font(.system(size: 17, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.mainColor)
                            .foregroundColor(.buttonTextColor)
                            .cornerRadius(14)
                    }
                    .padding(.horizontal, 40)

                    Button {
                        // Placeholder action
                    } label: {
                        Text("Skip for now")
                            .font(.system(size: 15))
                            .foregroundColor(.secondaryText)
                    }
                }
                .padding(.bottom, 40)

                Spacer()
            }
        }
    }

    // Reusable input field component
    @ViewBuilder
    private func inputField<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondaryText)
            
            content()
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.dividerGray.opacity(0.4), lineWidth: 1)
                )
        }
    }
}

#Preview {
    CreateWalletView()
}
