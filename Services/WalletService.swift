//
//  WalletService.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 25.11.2025.
//


import Foundation

final class WalletService {
    private let baseURL = "http://localhost:5084"

    // Fetch currency types
    func fetchCurrencies() async throws -> [CurrencyItem] {
        guard let url = URL(string: "\(baseURL)/api/enums/currency-types") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(CurrencyResponse.self, from: data)
        return response.data
    }

    // Fetch wallet types
    func fetchWalletTypes() async throws -> [WalletTypeItem] {
        guard let url = URL(string: "\(baseURL)/api/enums/wallet-types") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(WalletTypeResponse.self, from: data)
        return response.data
    }


    // Create wallet
    func createWallet(_ request: CreateWalletRequest, token: String) async throws {
        guard let url = URL(string: "\(baseURL)/wallets") else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("*/*", forHTTPHeaderField: "accept")

        urlRequest.httpBody = try JSONEncoder().encode(request)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            print("Server error: \(httpResponse.statusCode)")
            print(String(data: data, encoding: .utf8) ?? "")
            throw URLError(.badServerResponse)
        }
    }
}