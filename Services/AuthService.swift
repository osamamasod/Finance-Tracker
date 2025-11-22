//
//  AuthService.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 22.11.2025.
//


import Foundation

final class AuthService {
    private let baseURL = "http://127.0.0.1:5084"

    func register(_ requestModel: RegisterRequest) async throws -> RegisterResponse {
        guard let url = URL(string: "\(baseURL)/auth/register") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(requestModel)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data)
            let message = errorResponse?.message ?? "Server error with status code: \(httpResponse.statusCode)"
            throw APIError.serverError(message)
        }

        do {
            return try JSONDecoder().decode(RegisterResponse.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
}

struct ErrorResponse: Codable {
    let message: String
}