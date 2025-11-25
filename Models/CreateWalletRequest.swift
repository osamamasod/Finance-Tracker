//
//  CreateWalletRequest.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 25.11.2025.
//


import Foundation

struct CreateWalletRequest: Codable {
    let name: String
    let currency: String
    let walletType: String
    let balance: Double
}

struct CurrencyItem: Codable, Identifiable {
    let value: String
    let name: String
    var id: String { value }
}

struct CurrencyResponse: Codable {
    let status: Int
    let message: String
    let data: [CurrencyItem]
}

struct WalletTypeItem: Codable, Identifiable {
    let value: String
    let name: String
    var id: String { value }
}

struct WalletTypeResponse: Codable {
    let status: Int
    let message: String
    let data: [WalletTypeItem]
}
