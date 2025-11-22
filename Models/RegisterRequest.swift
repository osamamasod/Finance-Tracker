//
//  RegisterRequest.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 22.11.2025.
//


import Foundation

struct RegisterRequest: Codable {
    let name: String
    let email: String
    let password: String
}

struct RegisterResponse: Codable {
    let message: String?
    let token: String?
    let user: UserResponse?
}

struct UserResponse: Codable {
    let id: String
    let name: String
    let email: String
}