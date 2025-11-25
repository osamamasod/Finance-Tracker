//
//  CreateWalletViewModel.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 25.11.2025.
//


import Foundation
internal import Combine

@MainActor
final class CreateWalletViewModel: ObservableObject {
    @Published var walletName = ""
    @Published var selectedCurrencyIndex = 0
    @Published var selectedWalletTypeIndex = 0
    @Published var startingBalance = ""
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var navigateToDashboard = false

    @Published var currencies: [String] = []
    @Published var walletTypes: [String] = []

    private let walletService = WalletService()
    var authToken: String?

    func loadEnums() async {
        do {
            currencies = try await walletService.fetchCurrencies().map { $0.value }
            walletTypes = try await walletService.fetchWalletTypes().map { $0.value }
        } catch {
            alertMessage = "Failed to load currencies or wallet types."
            showAlert = true
            print("❌ Enum fetch error:", error)
        }
    }


    func createWallet() async {
        guard !walletName.isEmpty,
              let balance = Double(startingBalance),
              let token = authToken,
              currencies.indices.contains(selectedCurrencyIndex),
              walletTypes.indices.contains(selectedWalletTypeIndex) else {
            alertMessage = "Please fill in all required fields correctly."
            showAlert = true
            print("❌ Wallet creation failed: Missing input or auth token")
            return
        }

        let request = CreateWalletRequest(
            name: walletName,
            currency: currencies[selectedCurrencyIndex],
            walletType: walletTypes[selectedWalletTypeIndex],
            balance: balance
        )

        isLoading = true
        defer { isLoading = false }

        do {
                   
                    let createdWallet = try await walletService.createWallet(request, token: token)
                    print("✅ Wallet created:", createdWallet)
                    navigateToDashboard = true
                } catch {
                    alertMessage = "Failed to create wallet. Please try again."
                    showAlert = true
                    print("❌ Wallet creation failed:", error)
        }
    }
}
