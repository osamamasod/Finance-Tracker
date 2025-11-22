//
//  NetworkError.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 22.11.2025.
//


import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case serverError(String)
    case invalidData(String)
    case unauthorized
    case unknown
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .serverError(let message):
            return "Server error: \(message)"
        case .invalidData(let message):
            return "Invalid data: \(message)"
        case .unauthorized:
            return "Unauthorized access"
        case .unknown:
            return "Unknown error occurred"
        case .decodingError:
            return "Failed to decode response"
        }
    }
}