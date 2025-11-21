import SwiftUI

@main
struct Finance_TrackerApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.isAuthenticated {
                // Your main app content will go here later
                Text("Main App Content")
                    .onAppear {
                        // For testing authentication flow
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            appState.isAuthenticated = false
                        }
                    }
            } else {
                LaunchScreenView()
                    .environmentObject(appState)
            }
        }
    }
}
