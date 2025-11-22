import SwiftUI

struct RegisterView: View {
    enum Field {
        case name, email, password, confirmPassword
    }
    
    @StateObject private var viewModel = RegisterViewModel()
    @FocusState private var focusedField: Field?
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.pageBackground, Color.pageBackground.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    
                    // Header Section
                    VStack(spacing: 24) {
                        // App Icon
                        ZStack {
                            Circle()
                                .fill(Color.mainColor)
                                .frame(width: 80, height: 80)
                                .shadow(color: Color.mainColor.opacity(0.3), radius: 8, x: 0, y: 4)
                            
                            Image(systemName: "person.badge.plus.fill")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundColor(.buttonTextColor)
                        }
                        
                        VStack(spacing: 8) {
                            Text("Create Account")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.headerTextColor)
                            
                            Text("Join us to track your  finances")
                                .font(.body)
                                .foregroundColor(.secondaryText)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 30)
                    
                    // Form Section
                    VStack(spacing: 24) {
                        
                        // Error Message
                        if let errorMessage = viewModel.errorMessage {
                            ErrorMessageView(errorMessage: errorMessage)
                        }
                        
                        // Input Fields
                        VStack(spacing: 16) {
                            
                            InputField(
                                icon: "person.fill",
                                placeholder: "Full Name",
                                text: $viewModel.name,
                                focusedField: $focusedField,
                                fieldType: Field.name
                            )
                            
                            InputField(
                                icon: "envelope.fill",
                                placeholder: "Email Address",
                                text: $viewModel.email,
                                focusedField: $focusedField,
                                fieldType: Field.email
                            )
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            
                            InputField(
                                icon: "lock.fill",
                                placeholder: "Password",
                                text: $viewModel.password,
                                focusedField: $focusedField,
                                fieldType: Field.password,
                                isSecure: true
                            )
                            .textContentType(.newPassword)
                            
                            InputField(
                                icon: "lock.shield.fill",
                                placeholder: "Confirm Password",
                                text: $viewModel.confirmPassword,
                                focusedField: $focusedField,
                                fieldType: Field.confirmPassword,
                                isSecure: true
                            )
                            .textContentType(.newPassword)
                        }
                        
                        // Password Requirements
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password must contain:")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.secondaryText)
                            
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 4) {
                                    RequirementRow(met: viewModel.password.count >= 8, text: "8+ characters")
                                    RequirementRow(met: viewModel.password.rangeOfCharacter(from: .uppercaseLetters) != nil, text: "1 uppercase letter")
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    RequirementRow(met: viewModel.password.rangeOfCharacter(from: .decimalDigits) != nil, text: "1 number")
                                    RequirementRow(met: viewModel.password.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()_+-=[]{}|;:,.<>?")) != nil, text: "1 special character")
                                }
                            }
                            .font(.caption2)
                            .foregroundColor(.secondaryText)
                        }
                        .padding(.horizontal, 21)
                        
                        // Create Account Button
                        Button(action: {
                            hideKeyboard()
                            Task {
                                await viewModel.register()
                                if viewModel.registrationSuccess {
                                    appState.isAuthenticated = true
                                }
                            }
                        }) {
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Create Account")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                        }
                        .primaryButtonStyle()
                        .disabled(viewModel.isLoading || !viewModel.isFormValid)
                        .opacity(viewModel.isLoading || !viewModel.isFormValid ? 0.5 : 1)
                        
                        // Divider
                        HStack(spacing: 16) {
                            Rectangle()
                                .fill(Color.dividerGray)
                                .frame(height: 1)
                            
                            Text("or")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.secondaryText)
                            
                            Rectangle()
                                .fill(Color.dividerGray)
                                .frame(height: 1)
                        }
                        .padding(.horizontal, 21)
                        .padding(.vertical, 16)
                        
                        // Sign In Option
                        HStack(spacing: 4) {
                            Text("Already have an account?")
                                .foregroundColor(.secondaryText)
                            
                            Button("Sign In") {
                                dismiss()
                            }
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.mainColor)
                        }
                        .font(.subheadline)
                    }
                    
                    Spacer().frame(height: 20)
                    
                    // Footer
                    VStack(spacing: 8) {
                        Text("By creating an account, you agree to our")
                            .font(.caption)
                            .foregroundColor(.secondaryText)
                        
                        HStack(spacing: 16) {
                            Button("Terms of Service") {}
                            
                            Circle()
                                .fill(Color.secondaryText)
                                .frame(width: 4, height: 4)
                            
                            Button("Privacy Policy") {}
                        }
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.mainColor)
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarBackButtonHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: viewModel.registrationSuccess) { success in
            if success {
                appState.isAuthenticated = true
            }
        }
    }
}

// Helper view for error messages
struct ErrorMessageView: View {
    let errorMessage: String
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
            Text(errorMessage)
                .font(.caption)
                .foregroundColor(.red)
            Spacer()
        }
        .padding()
        .background(Color.red.opacity(0.1))
        .cornerRadius(8)
        .padding(.horizontal, 21)
    }
}

// Helper view for password requirements
struct RequirementRow: View {
    let met: Bool
    let text: String
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: met ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 12))
                .foregroundColor(met ? .green : .secondaryText)
            
            Text(text)
                .strikethrough(!met, color: .secondaryText)
        }
    }
}

#Preview {
    NavigationView {
        RegisterView()
            .environmentObject(AppState())
    }
}
