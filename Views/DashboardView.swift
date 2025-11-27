//
//  DashboardView.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 27.11.2025.
//

import SwiftUI

struct DashboardView: View {
    private let authToken: String

    init(authToken: String) {
        self.authToken = authToken
    }

    var body: some View {
        TabView {
            HomeView(authToken: authToken)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }
            
            AnalyticsView(authToken: authToken)
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Analytics")
                }
            
            ProfileView(authToken: authToken)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DashboardView(authToken: "dummy_token_for_preview")
}
