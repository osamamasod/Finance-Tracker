//
//  AnalyticsView.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 27.11.2025.
//

import SwiftUI

struct AnalyticsView: View {
    let authToken: String
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
              
                Rectangle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(height: 200)
                    .overlay(
                        Text("Spending Chart")
                            .foregroundColor(.gray)
                    )
                    .cornerRadius(10)
                
               
                VStack(alignment: .leading) {
                    Text("Expense Breakdown")
                        .font(.headline)
                    
                    ForEach(0..<5) { index in
                        HStack {
                            Text("Category \(index + 1)")
                            Spacer()
                            Text("$\(index * 100 + 50)")
                                .foregroundColor(.blue)
                        }
                        .padding(.vertical, 5)
                    }
                }
                .padding()
                
               
                HStack(spacing: 15) {
                    VStack {
                        Text("Income")
                            .font(.caption)
                        Text("$2,500")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    VStack {
                        Text("Expenses")
                            .font(.caption)
                        Text("$1,200")
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    VStack {
                        Text("Savings")
                            .font(.caption)
                        Text("$1,300")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Analytics")
        }
    }
}

#Preview {
    AnalyticsView(authToken: "dummy_token_for_preview")
}
