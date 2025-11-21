import SwiftUI

struct WelcomeHeader: View {
    @State private var displayedText = ""
    @State private var cursorVisible = true
    private let fullText = "Finance Tracker"
    
    var body: some View {
        VStack(spacing: 16) {
            // App Icon
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.mainColor, Color.mainColor.opacity(0.8)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)
                    .shadow(color: Color.mainColor.opacity(0.4), radius: 12, x: 0, y: 6)
                
                Image(systemName: "wallet.pass.fill")
                    .font(.system(size: 40, weight: .medium))
                    .foregroundColor(.buttonTextColor)
            }
            
          
            ZStack(alignment: .leading) {
                Text(displayedText)
                    .font(.system(size: 36, weight: .black, design: .rounded))
                    .foregroundColor(.headerTextColor)
                
            
                if cursorVisible {
                    Rectangle()
                        .fill(Color.mainColor)
                        .frame(width: 3, height: 42)
                        .offset(x: getCursorOffset())
                }
            }
            .frame(height: 50)
            .onAppear {
                startLoopingTypewriter()
                startCursorBlink()
            }
            
            // Subtitle
            Text("Take control of your financial future")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.secondaryText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding(.bottom, 20)
    }
    
    private func getCursorOffset() -> CGFloat {
        let baseWidth: CGFloat = 36 // Approximate character width
        return CGFloat(displayedText.count) * baseWidth
    }
    
    private func startCursorBlink() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.3)) {
                cursorVisible.toggle()
            }
        }
    }
    
    private func startLoopingTypewriter() {
        typeWriterEffect {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                startLoopingTypewriter()
            }
        }
    }
    
    private func typeWriterEffect(completion: @escaping () -> Void) {
        displayedText = ""
        var charIndex = 0.0
        let typingSpeed = 0.08
        
        for letter in fullText {
            DispatchQueue.main.asyncAfter(deadline: .now() + charIndex * typingSpeed) {
                displayedText.append(letter)
                if displayedText.count == fullText.count {
                  
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        completion()
                    }
                }
            }
            charIndex += 1
        }
    }
}

// MARK: - ContentView (Home Page)
struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            ZStack {
                
                AnimatedBackground()
                
                VStack {
                    Spacer()
                    
                    WelcomeHeader()
                    
                    Spacer()
                    
                  
                    VStack(spacing: 16) {
              
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                                .primaryButtonStyle()
                        }
                        
                 
                        NavigationLink(destination: RegisterView()) {
                            Text("Register")
                                .primaryButtonStyle()
                        }
                    }
                    .padding(.bottom, 80)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.pageBackground.ignoresSafeArea())
            }
            .navigationBarHidden(true)
        }
        .environmentObject(appState)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - Animated Background
struct AnimatedBackground: View {
    @State private var animateGradient = false
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.pageBackground,
                Color.pageBackground.opacity(0.9),
                Color.pageBackground
            ]),
            startPoint: animateGradient ? .topLeading : .bottomTrailing,
            endPoint: animateGradient ? .bottomTrailing : .topLeading
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
        .environmentObject(AppState())
}
