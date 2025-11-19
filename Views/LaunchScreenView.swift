//
//  LaunchScreenView.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 19.11.2025.
//


import SwiftUI

struct LaunchScreenView: View {
    @State private var animateCoins = false
    @State private var isActive = false

    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()

            VStack {
                Spacer()

                // Wallet Icon
                Image(systemName: "wallet.pass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)

                // Animated Coins
                ZStack {
                    ForEach(0..<5) { index in
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.yellow)
                            .rotationEffect(.degrees(animateCoins ? 360 : 0))
                            .scaleEffect(animateCoins ? 1.2 : 0.8)
                            .offset(y: animateCoins ? -120 : 0)
                            .opacity(animateCoins ? 0 : 1)
                            .animation(
                                Animation.easeOut(duration: 1.2)
                                    .repeatForever()
                                    .delay(Double(index) * 0.2),
                                value: animateCoins
                            )
                    }
                }
                .frame(height: 120)
                .padding(.top, 16)

                // App Name
                Text("Finance Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 16)

                Spacer()

                // Progress indicator
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .padding(.bottom, 40)
            }
        }
        .onAppear {
            animateCoins = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                isActive = true
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            ContentView()
        }
    }
}
