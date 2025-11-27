//
//  HomeView.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 27.11.2025.
//

import SwiftUI

struct HomeView: View {
    let authToken: String
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                VStack {
                    Text("Total Balance")
                        .font(.headline)
                    Text("$5,250.75")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                
                HStack(spacing: 20) {
                    Button("Add Money") {
                        
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    Button("Send Money") {
                       
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
               
                VStack(alignment: .leading) {
                    Text("Recent Transactions")
                        .font(.headline)
                    
                    ForEach(0..<3) { _ in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Transaction")
                                Text("Today")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("-$25.00")
                                .foregroundColor(.red)
                        }
                        .padding(.vertical, 5)
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView(authToken: "preview-token")
}
