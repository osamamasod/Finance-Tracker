import Foundation
internal import Combine

@MainActor
final class LoginViewModel: ObservableObject {

@Published var email = ""
@Published var password = ""
@Published var isLoading = false
@Published var errorMessage: String? = nil
@Published var isLoggedIn = TokenManager.isLoggedIn



private let repository: LoginRepositoryProtocol


init(repository: LoginRepositoryProtocol = LoginRepository()) {
    self.repository = repository
}

func login() async -> Bool {
    if let validationError = validateInputs() {
        errorMessage = validationError
        return false
    }

    isLoading = true
    errorMessage = nil

    defer { isLoading = false }

    do {
        let token = try await repository.login(email: email, password: password)
        TokenManager.token = token
        isLoggedIn = true
        password = ""
        print("✅ Login successful, token stored: \(token.prefix(20))...")
        return true
    } catch {
        errorMessage = parseError(error)
        print("❌ Login failed: \(error)")
        return false
    }
}


private func validateInputs() -> String? {
    guard !email.isEmpty, !password.isEmpty else { return "Please enter both email and password." }
    guard email.contains("@") else { return "Please enter a valid email address." }
    return nil
}


private func parseError(_ error: Error) -> String {
    if let loginError = error as? LoginError {
        return loginError.localizedDescription
    }
    return error.localizedDescription
}


}


protocol LoginRepositoryProtocol {
func login(email: String, password: String) async throws -> String
}

extension LoginRepository: LoginRepositoryProtocol {}
