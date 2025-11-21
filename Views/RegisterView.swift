import SwiftUI

struct RegisterView: View {
    enum Field {
        case name, email, password, confirmPassword
    }
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @FocusState private var focusedField: Field?
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            // Background with subtle gradient (matches login)
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
                            
                            Text("Join us to start tracking your finances")
                                .font(.body)
                                .foregroundColor(.secondaryText)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 30)
                    
                    // Form Section
                    VStack(spacing: 24) {
                        // Input Fields - Perfectly aligned with login page
                        VStack(spacing: 16) {
                            InputField(
                                icon: "person.fill",
                                placeholder: "Full Name",
                                text: $name,
                                focusedField: $focusedField,
                                fieldType: Field.name
                            )
                            
                            InputField(
                                icon: "envelope.fill",
                                placeholder: "Email Address",
                                text: $email,
                                focusedField: $focusedField,
                                fieldType: Field.email
                            )
                            
                            InputField(
                                icon: "lock.fill",
                                placeholder: "Password",
                                text: $password,
                                focusedField: $focusedField,
                                fieldType: Field.password,
                                isSecure: true
                            )
                            
                            InputField(
                                icon: "lock.shield.fill",
                                placeholder: "Confirm Password",
                                text: $confirmPassword,
                                focusedField: $focusedField,
                                fieldType: Field.confirmPassword,
                                isSecure: true
                            )
                        }
                        
                        // Password Requirements
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password must contain:")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.secondaryText)
                            
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 4) {
                                    RequirementRow(met: password.count >= 8, text: "8+ characters")
                                    RequirementRow(met: password.rangeOfCharacter(from: .uppercaseLetters) != nil, text: "1 uppercase letter")
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    RequirementRow(met: password.rangeOfCharacter(from: .decimalDigits) != nil, text: "1 number")
                                    RequirementRow(met: password.rangeOfCharacter(from: .symbols) != nil, text: "1 special character")
                                }
                            }
                            .font(.caption2)
                            .foregroundColor(.secondaryText)
                        }
                        .padding(.horizontal, 21)
                        
                        // Create Account Button
                        Button(action: {
                            // Simulate registration and login
                            appState.isAuthenticated = true
                        }) {
                            Text("Create Account")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                        .primaryButtonStyle()
                        
                        // Divider with "or"
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
                            
                            NavigationLink("Sign In") {
                                LoginView()
                            }
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.mainColor)
                        }
                        .font(.subheadline)
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    // Footer
                    VStack(spacing: 8) {
                        Text("By creating an account, you agree to our")
                            .font(.caption)
                            .foregroundColor(.secondaryText)
                        
                        HStack(spacing: 16) {
                            Button("Terms of Service") {
                                // Handle terms
                            }
                            
                            Circle()
                                .fill(Color.secondaryText)
                                .frame(width: 4, height: 4)
                            
                            Button("Privacy Policy") {
                                // Handle privacy
                            }
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

// MARK: - Preview
#Preview {
    NavigationView {
        RegisterView()
            .environmentObject(AppState())
    }
}
