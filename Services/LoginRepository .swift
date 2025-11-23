//
//  LoginError.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 23.11.2025.
//


import Foundation

enum LoginError: Error, LocalizedError {
    case invalidURL
    case decodingError
    case serverError(String)
    case unauthorized
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid server URL."
        case .decodingError: return "Failed to decode server response."
        case .serverError(let msg): return msg
        case .unauthorized: return "Invalid email or password."
        case .unknown: return "An unknown error occurred."
        }
    }
}

final class LoginRepository {
    func login(email: String, password: String) async throws -> String {
        guard let url = URL(string: "http://localhost:5084/auth/login") else {
            throw LoginError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let payload = LoginRequest(email: email, password: password)
        request.httpBody = try JSONEncoder().encode(payload)

        print("🔐 Login Request:")
        print("URL: \(url)")
        print("Email: \(email)")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw LoginError.unknown
        }

        if let responseString = String(data: data, encoding: .utf8) {
            print("📡 Login Response Status: \(httpResponse.statusCode)")
            print("📄 Login Response Body: \(responseString)")
        }

        switch httpResponse.statusCode {
        case 200:
            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                print("✅ Login successful, token received")
                return loginResponse.token
            } catch {
                print("❌ Token decoding error: \(error)")
                throw LoginError.decodingError
            }
            
        case 401:
            throw LoginError.unauthorized
            
        case 400...499:
            do {
                let errorResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                throw LoginError.serverError(errorResponse.message)
            } catch {
                throw LoginError.serverError("Invalid email or password")
            }
            
        case 500...599:
            throw LoginError.serverError("Server error, please try again later")
            
        default:
            throw LoginError.unknown
        }
    }
}
