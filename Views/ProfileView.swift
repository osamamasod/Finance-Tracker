//
//  ProfileView.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 27.11.2025.
//

import SwiftUI

struct ProfileView: View {
    let authToken: String
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
               
                VStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.blue)
                    
                    Text("osama masoud")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("osama.doe@gmail.com")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
         
                VStack(spacing: 0) {
                    ProfileRow(icon: "person", title: "Personal Information")
                    ProfileRow(icon: "bell", title: "Notifications")
                    ProfileRow(icon: "lock", title: "Security")
                    ProfileRow(icon: "creditcard", title: "Payment Methods")
                    ProfileRow(icon: "questionmark.circle", title: "Help & Support")
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
             
                Button("Log Out") {
           
                }
                .foregroundColor(.red)
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}

struct ProfileRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 30)
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
    }
}

#Preview {
    ProfileView(authToken: "dummy_token_for_preview")
}
