//
//  FetchWalletsService.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 27.11.2025.
//


import Foundation

// Main service
final class FetchWalletsService {
    private let baseURL = "http://localhost:5084"

    func fetchWallets(token: String) async throws -> [WalletModel] {
        guard let url = URL(string: "\(baseURL)/wallets") else { throw APIError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(String(data: data, encoding: .utf8) ?? "Unknown error")
        }

        let apiResponse = try JSONDecoder().decode(WalletsResponse.self, from: data)
        return apiResponse.data
    }

    func fetchTotalBalance(token: String, currency: String? = nil) async throws -> Double {
        var urlString = "\(baseURL)/wallets/total-balance"
        if let currency = currency {
            urlString += "?currency=\(currency)"
        }

        guard let url = URL(string: urlString) else { throw APIError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(String(data: data, encoding: .utf8) ?? "Unknown error")
        }

        // Debug print to see response
        if let responseString = String(data: data, encoding: .utf8) {
            print("💰 Total Balance Response: \(responseString)")
        }

        do {
            let responseObj = try JSONDecoder().decode(TotalBalanceResponse.self, from: data)
            return responseObj.data.totalBalance
        } catch {
            print("❌ DECODING ERROR: \(error)")
            throw error
        }
    }
}
