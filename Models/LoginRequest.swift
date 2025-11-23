//
//  LoginRequest.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 23.11.2025.
//


import Foundation

// MARK: - Request
struct LoginRequest: Codable {
    let email: String
    let password: String
}

// MARK: - Response
struct LoginResponse: Codable {
    let status: Int
    let message: String
    let token: String
}
