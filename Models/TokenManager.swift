//
//  TokenManager.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 22.11.2025.


import Foundation

final class TokenManager {
    private static let tokenKey = "authToken"
    
    static var token: String? {
        get {
            return UserDefaults.standard.string(forKey: tokenKey)
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: tokenKey)
            } else {
                UserDefaults.standard.removeObject(forKey: tokenKey)
            }
        }
    }
    
    // ✅ Add this
    static var isLoggedIn: Bool {
        return token != nil
    }
    
    static func clearToken() {
        token = nil
    }
}

