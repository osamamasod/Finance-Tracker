import Foundation
internal import Combine

@MainActor
final class RegisterViewModel: ObservableObject {

    // MARK: - Inputs
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    // MARK: - UI state
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var registrationSuccess: Bool = false

    // Exposed auth token (optional)
    @Published var authToken: String? = TokenManager.token

    private let authService = AuthService()

    // MARK: - Derived
    var isFormValid: Bool {
        // Keep the same rules used in validation
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        isValidEmail(email) &&
        password.count >= 6 &&
        password == confirmPassword
    }

    // MARK: - Register
    func register() async {
        errorMessage = nil

        if let validationError = validateForm() {
            errorMessage = validationError
            return
        }

        isLoading = true
        defer { isLoading = false }

        let request = RegisterRequest(
            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
            email: email.lowercased().trimmingCharacters(in: .whitespacesAndNewlines),
            password: password
        )

        do {
            let response = try await authService.register(request)
            if let token = response.token {
                TokenManager.token = token
                authToken = token
                registrationSuccess = true

                // Clear sensitive fields
                password = ""
                confirmPassword = ""
            } else {
                // Acceptable case if API returns no token
                errorMessage = response.message ?? "Registration succeeded but no token was returned."
            }
        } catch {
            errorMessage = readableError(error)
        }
    }

    // MARK: - Validation
    func validateForm() -> String? {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            password.isEmpty ||
            confirmPassword.isEmpty {
            return "All fields are required."
        }

        if !isValidEmail(email) {
            return "Please enter a valid email."
        }

        if password != confirmPassword {
            return "Passwords do not match."
        }

        if password.count < 6 {
            return "Password must be at least 6 characters."
        }

        return nil
    }

    private func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: email)
    }

    private func readableError(_ error: Error) -> String {
        if let apiError = error as? APIError {
            return apiError.errorDescription ?? "An unexpected error occurred."
        }
        return error.localizedDescription
    }
}
