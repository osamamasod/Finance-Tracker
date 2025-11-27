//
//  WalletModel.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 27.11.2025.
//



struct WalletModel: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let balance: Double
    let currency: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "walletId"
        case name, balance, currency
    }
    

}


struct WalletsResponse: Codable {
    let status: Int
    let message: String
    let data: [WalletModel]
}


struct TotalBalanceResponse: Codable {
    let status: Int
    let message: String
    let data: TotalBalanceData
    
    struct TotalBalanceData: Codable {
        let totalBalance: Double
        let currency: String
        let walletBalances: [WalletBalance]?
        
        
        var total: Double {
            return totalBalance
        }
    }
    
    struct WalletBalance: Codable {
        let walletId: String
        let name: String
        let currency: String
        let balance: Double
        let convertedBalance: Double
        let exchangeRate: Double
    }
}
