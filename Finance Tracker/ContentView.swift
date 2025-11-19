import SwiftUI

struct WelcomeHeader: View {
    @State private var displayedText = ""
    private let fullText = "Finance Tracker"
    
    var body: some View {
        VStack(spacing: 8) {
            Text(displayedText)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .onAppear {
                    startLoopingTypewriter()
                }
        }
        .multilineTextAlignment(.center)
        .padding(.bottom, 30)
    }
    
    private func startLoopingTypewriter() {
        typeWriterEffect {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                startLoopingTypewriter()
            }
        }
    }
    
    private func typeWriterEffect(completion: @escaping () -> Void) {
        displayedText = ""
        var charIndex = 0.0
        for letter in fullText {
            DispatchQueue.main.asyncAfter(deadline: .now() + charIndex * 0.1) {
                displayedText.append(letter)
                if displayedText.count == fullText.count {
                    completion()
                }
            }
            charIndex += 1
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                WelcomeHeader()
                
                Spacer()
                
                VStack(spacing: 16) {
                    NavigationLink(destination: Text("Login Screen")) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.blue)
                            .cornerRadius(12)
                            .padding(.horizontal, 24)
                    }
                    
                    NavigationLink(destination: Text("Register Screen")) {
                        Text("Register")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.green)
                            .cornerRadius(12)
                            .padding(.horizontal, 24)
                    }
                }
                .padding(.bottom, 80)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground).ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
