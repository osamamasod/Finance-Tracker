import SwiftUI

struct LaunchScreenView: View {
    @State private var animateCoins = false
    @State private var scaleLogo = false
    @State private var showTitle = false
    @State private var pulseProgress = false
    @State private var rotateGradient = false
    @State private var sparkleEffect = false
    @State private var isActive = false
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            // Animated Gradient Background
            AngularGradient(
                gradient: Gradient(colors: [
                    Color.mainColor,
                    Color(hex: "#7A352E"),
                    Color.mainColor,
                    Color(hex: "#3A110C"),
                    Color.mainColor
                ]),
                center: .center,
                angle: .degrees(rotateGradient ? 360 : 0)
            )
            .ignoresSafeArea()
            .overlay(
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.3), Color.clear]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
            )
            
            // Floating particles in background
            ForEach(0..<15) { index in
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: CGFloat.random(in: 2...8), height: CGFloat.random(in: 2...8))
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                    )
                    .opacity(sparkleEffect ? 1 : 0.3)
                    .scaleEffect(sparkleEffect ? 1.5 : 0.5)
                    .animation(
                        Animation.easeInOut(duration: 1.5)
                            .repeatForever()
                            .delay(Double(index) * 0.1),
                        value: sparkleEffect
                    )
            }
            
            VStack {
                Spacer()
                
                // Main Logo Container
                ZStack {
                    // Glow effect
                    Circle()
                        .fill(Color.mainColor)
                        .frame(width: 140, height: 140)
                        .blur(radius: 20)
                        .opacity(scaleLogo ? 0.6 : 0.3)
                        .scaleEffect(scaleLogo ? 1.2 : 0.8)
                    
                    // Logo with gradient
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.mainColor, Color(hex: "#7A352E")]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 120, height: 120)
                        .scaleEffect(scaleLogo ? 1.1 : 1.0)
                        .shadow(color: Color.mainColor.opacity(0.6), radius: 20, x: 0, y: 10)
                    
                    Image(systemName: "wallet.pass.fill")
                        .font(.system(size: 50, weight: .medium))
                        .foregroundColor(.buttonTextColor)
                        .scaleEffect(scaleLogo ? 1.05 : 1.0)
                }
                
                // Animated Coins with enhanced effects
                ZStack {
                    ForEach(0..<8) { index in
                        CoinView(index: index, animateCoins: animateCoins)
                    }
                }
                .frame(height: 150)
                .padding(.top, 30)
                
                // App Title with typewriter effect
                VStack(spacing: 8) {
                    Text("Finance Tracker")
                        .font(.system(size: 42, weight: .black, design: .rounded))
                        .foregroundColor(.buttonTextColor)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                        .opacity(showTitle ? 1 : 0)
                        .offset(y: showTitle ? 0 : 20)
                    
                    Text("Smart Money Management")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.buttonTextColor.opacity(0.9))
                        .opacity(showTitle ? 1 : 0)
                        .offset(y: showTitle ? 0 : 10)
                }
                .padding(.top, 20)
                
                Spacer()
                
                // Enhanced Progress Indicator
                VStack(spacing: 20) {
                    // Custom progress bar
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.buttonTextColor.opacity(0.2))
                            .frame(width: 200, height: 6)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.buttonTextColor)
                            .frame(width: pulseProgress ? 200 : 0, height: 6)
                            .animation(
                                Animation.easeInOut(duration: 2.0),
                                value: pulseProgress
                            )
                    }
                    
                    Text("Loading your financial world...")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.buttonTextColor.opacity(0.8))
                        .opacity(pulseProgress ? 1 : 0.5)
                        .scaleEffect(pulseProgress ? 1.05 : 1.0)
                }
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            // Start all animations in sequence
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                scaleLogo = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
                animateCoins = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
                withAnimation(.easeOut(duration: 0.8)) {
                    showTitle = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.easeInOut(duration: 2.0)) {
                    pulseProgress = true
                }
            }
            
            // Background animations
            withAnimation(.linear(duration: 8.0).repeatForever(autoreverses: false)) {
                rotateGradient = true
            }
            
            withAnimation(.easeInOut(duration: 2.0).repeatForever()) {
                sparkleEffect.toggle()
            }
            
            // Navigate after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isActive = true
                }
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            ContentView()
                .environmentObject(appState)
        }
    }
}

// Enhanced Coin View
struct CoinView: View {
    let index: Int
    let animateCoins: Bool
    
    var body: some View {
        let angle = Double(index) * (360.0 / 8.0)
        let radius: CGFloat = 60
        
        Image(systemName: "dollarsign.circle.fill")
            .font(.system(size: 24))
            .foregroundColor(.yellow)
            .background(
                Circle()
                    .fill(Color.orange)
                    .frame(width: 28, height: 28)
                    .blur(radius: 4)
                    .opacity(animateCoins ? 0.8 : 0)
            )
            .rotationEffect(.degrees(animateCoins ? 720 : 0))
            .scaleEffect(animateCoins ? 1.3 : 0.7)
            .offset(
                x: animateCoins ? cos(angle * .pi / 180) * radius : 0,
                y: animateCoins ? sin(angle * .pi / 180) * radius : 0
            )
            .opacity(animateCoins ? 0 : 1)
            .animation(
                Animation.spring(response: 1.2, dampingFraction: 0.6)
                    .delay(Double(index) * 0.1),
                value: animateCoins
            )
    }
}

// MARK: - Preview
struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(AppState())
            .previewDevice("iPhone 14")
    }
}
