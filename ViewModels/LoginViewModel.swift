import Foundation
internal import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var isLoggedIn = TokenManager.isLoggedIn
    
    private let repository = LoginRepository()
    
    func login() async -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter both email and password."
            return false
        }
        
        guard email.contains("@") else {
            errorMessage = "Please enter a valid email address."
            return false
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let token = try await repository.login(email: email, password: password)
            TokenManager.token = token
            isLoggedIn = true
            password = ""
            print("✅ Login successful, token stored: \(token.prefix(20))...")
            isLoading = false
            return true
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Login failed: \(error)")
            isLoading = false
            return false
        }
    }
}
