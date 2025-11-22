//
//  APIError.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 22.11.2025.
//


import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(String)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid response from server"
        case .decodingError: return "Failed to decode server response"
        case .serverError(let message): return message
        case .unknown(let error): return error.localizedDescription
        }
    }
}