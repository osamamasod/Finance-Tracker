//
//  CreateWalletView.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 25.11.2025.
//

import SwiftUI

struct CreateWalletView: View {
    @StateObject private var viewModel: CreateWalletViewModel
    @State private var showDashboard = false
    @FocusState private var focusedField: Field?
    
    enum Field {
        case walletName, startingBalance
    }

    init(authToken: String) {
        let vm = CreateWalletViewModel()
        vm.authToken = authToken
        _viewModel = StateObject(wrappedValue: vm)
    }

    var body: some View {
        ZStack {
            Color.pageBackground.ignoresSafeArea()

            VStack(spacing: 0) {
               
                VStack(spacing: 16) {
                    Image(systemName: "creditcard.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.mainColor)
                    
                    VStack(spacing: 8) {
                        Text("Create Your Wallet")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.headerTextColor)
                            .multilineTextAlignment(.center)

                        Text("Add your wallet to start tracking your income .")
                            .font(.system(size: 16))
                            .foregroundColor(.secondaryText)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                    }
                }
                .padding(.top, 40)
                .padding(.bottom, 40)
                .padding(.horizontal, 32)

    
                VStack(spacing: 24) {
                    inputField(
                        title: "Wallet Name",
                        icon: "person.fill",
                        field: .walletName
                    ) {
                        TextField("e.g., Personal Wallet", text: $viewModel.walletName)
                            .focused($focusedField, equals: .walletName)
                            .autocapitalization(.words)
                    }

                    inputField(
                        title: "Currency",
                        icon: "dollarsign.circle.fill"
                    ) {
                        HStack {
                            Text(viewModel.currencies[safe: viewModel.selectedCurrencyIndex] ?? "Select Currency")
                                .foregroundColor(viewModel.selectedCurrencyIndex == 0 ? .secondaryText : .primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondaryText)
                        }
                        .overlay(
                            Picker("Currency", selection: $viewModel.selectedCurrencyIndex) {
                                ForEach(Array(viewModel.currencies.enumerated()), id: \.offset) { index, currency in
                                    Text(currency).tag(index)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .opacity(0.02)
                        )
                    }

                    inputField(
                        title: "Wallet Type",
                        icon: "creditcard.fill"
                    ) {
                        HStack {
                            Text(viewModel.walletTypes[safe: viewModel.selectedWalletTypeIndex] ?? "Select Type")
                                .foregroundColor(viewModel.selectedWalletTypeIndex == 0 ? .secondaryText : .primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondaryText)
                        }
                        .overlay(
                            Picker("Wallet Type", selection: $viewModel.selectedWalletTypeIndex) {
                                ForEach(Array(viewModel.walletTypes.enumerated()), id: \.offset) { index, type in
                                    Text(type).tag(index)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .opacity(0.02)
                        )
                    }

                    inputField(
                        title: "Starting Balance",
                        icon: "chart.line.uptrend.xyaxis",
                        field: .startingBalance
                    ) {
                        TextField("0.00", text: $viewModel.startingBalance)
                            .focused($focusedField, equals: .startingBalance)
                            .keyboardType(.decimalPad)
                    }
                }
                .padding(.vertical, 32)
                .padding(.horizontal, 24)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 8)
                .padding(.horizontal, 24)
                .padding(.bottom, 40)

                
                VStack(spacing: 16) {
                    Button {
                        Task {
                            await viewModel.createWallet()
                            if viewModel.navigateToDashboard {
                                showDashboard = true
                            }
                        }
                    } label: {
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.mainColor)
                                .cornerRadius(14)
                        } else {
                            Text("Create Wallet")
                                .font(.system(size: 17, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.mainColor)
                                .foregroundColor(.buttonTextColor)
                                .cornerRadius(14)
                        }
                    }
                    .padding(.horizontal, 40)

                    Button {
                        showDashboard = true
                    } label: {
                        Text("Skip for now")
                            .font(.system(size: 15))
                            .foregroundColor(.secondaryText)
                    }
                }
                .padding(.bottom, 40)

                Spacer()
            }
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {}
        }
        .fullScreenCover(isPresented: $showDashboard) {
            if let token = viewModel.authToken {
                DashboardView(authToken: token)
                    .interactiveDismissDisabled(true)
            } else {
                Text("Error: No auth token")
            }
        }
        .task {
            await viewModel.loadEnums()
        }
        .onTapGesture {
            focusedField = nil
        }
    }

    
    @ViewBuilder
    private func inputField<Content: View>(
        title: String,
        icon: String? = nil,
        field: Field? = nil,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 14))
                        .foregroundColor(.mainColor)
                        .frame(width: 16)
                }
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondaryText)
                
                Spacer()
            }

            content()
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            focusedField == field ? Color.mainColor.opacity(0.6) : Color.dividerGray.opacity(0.4),
                            lineWidth: focusedField == field ? 1.5 : 1
                        )
                )
        }
    }
}


extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    CreateWalletView(authToken: "dummy_token_for_preview")
}
