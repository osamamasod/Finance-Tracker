import SwiftUI

struct LoginView: View {
    enum Field {
        case email, password
    }
    
    @State private var email = ""
    @State private var password = ""
    @FocusState private var focusedField: Field?
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            // Background with subtle gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.pageBackground, Color.pageBackground.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Section
                VStack(spacing: 24) {
                    // App Icon
                    ZStack {
                        Circle()
                            .fill(Color.mainColor)
                            .frame(width: 80, height: 80)
                            .shadow(color: Color.mainColor.opacity(0.3), radius: 8, x: 0, y: 4)
                        
                        Image(systemName: "wallet.pass.fill")
                            .font(.system(size: 32, weight: .medium))
                            .foregroundColor(.buttonTextColor)
                    }
                    
                    VStack(spacing: 8) {
                        Text("Welcome Back")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.headerTextColor)
                        
                        Text("Sign in to continue your financial journey")
                            .font(.body)
                            .foregroundColor(.secondaryText)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.top, 60)
                .padding(.bottom, 40)
                
                // Form Section
                VStack(spacing: 24) {
                    // Input Fields - Now perfectly aligned with button
                    VStack(spacing: 16) {
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
                    }
                    
                    // Forgot Password
                    HStack {
                        Spacer()
                        Button("Forgot Password?") {
                            // Handle forgot password
                        }
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.mainColor)
                    }
                    .padding(.horizontal, 21) // Match button padding
                    
                    // Login Button - Now perfectly matches field width
                    Button(action: {
                        // Simulate login
                        appState.isAuthenticated = true
                    }) {
                        Text("Sign In")
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
                    
                    // Sign Up Option
                    HStack(spacing: 4) {
                        Text("Don't have an account?")
                            .foregroundColor(.secondaryText)
                        
                        NavigationLink("Sign Up") {
                            RegisterView()
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.mainColor)
                    }
                    .font(.subheadline)
                }
                
                Spacer()
                
                // Footer
                VStack(spacing: 8) {
                    Text("By continuing, you agree to our")
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
        .navigationBarBackButtonHidden(false)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        LoginView()
            .environmentObject(AppState())
    }
}
