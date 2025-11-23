import SwiftUI

struct LoginView: View {
    enum Field {
        case email, password
    }
    
    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var focusedField: Field?
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.pageBackground, Color.pageBackground.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(spacing: 24) {
                    ZStack {
                        Circle()
                            .fill(Color.mainColor)
                            .frame(width: 80, height: 80)
                            .shadow(color: Color.mainColor.opacity(0.3), radius: 8)
                        
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
                
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        InputField(
                            icon: "envelope.fill",
                            placeholder: "Email Address",
                            text: $viewModel.email,
                            focusedField: $focusedField,
                            fieldType: Field.email
                        )
                        
                        InputField(
                            icon: "lock.fill",
                            placeholder: "Password",
                            text: $viewModel.password,
                            focusedField: $focusedField,
                            fieldType: Field.password,
                            isSecure: true
                        )
                    }
                    
                    HStack {
                        Spacer()
                        Button("Forgot Password?") {}
                            .font(.subheadline)
                            .foregroundColor(.mainColor)
                    }
                    .padding(.horizontal, 21)
                    
                    Button {
                        Task {
                            if await viewModel.login() {
                                appState.isAuthenticated = true
                            }
                        }
                    } label: {
                        if viewModel.isLoading {
                            ProgressView().tint(.white)
                        } else {
                            Text("Sign In")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                    }
                    .primaryButtonStyle()
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .padding(.top, 8)
                    }
                    
                    HStack(spacing: 16) {
                        Rectangle().fill(Color.dividerGray).frame(height: 1)
                        Text("or")
                            .font(.caption)
                            .foregroundColor(.secondaryText)
                        Rectangle().fill(Color.dividerGray).frame(height: 1)
                    }
                    
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
                }
                
                Spacer()
                
                VStack(spacing: 8) {
                    Text("By continuing, you agree to our")
                        .font(.caption)
                        .foregroundColor(.secondaryText)
                    
                    HStack(spacing: 16) {
                        Button("Terms of Service") {}
                        Circle().fill(Color.secondaryText).frame(width: 4, height: 4)
                        Button("Privacy Policy") {}
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

#Preview {
    NavigationView {
        LoginView()
            .environmentObject(AppState())
    }
}
