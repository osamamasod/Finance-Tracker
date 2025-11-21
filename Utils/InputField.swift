//
//  InputField.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 21.11.2025.
//


import SwiftUI

struct InputField<FieldType: Hashable>: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    @FocusState.Binding var focusedField: FieldType?
    let fieldType: FieldType
    var isSecure: Bool = false

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)

            if isSecure {
                SecureField(placeholder, text: $text)
                    .focused($focusedField, equals: fieldType)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(isEmail ? .emailAddress : .default)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: fieldType)
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(focusedField == fieldType ? Color.mainColor : Color.dividerGray, lineWidth: 1.2)
        )
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
        .padding(.horizontal, 19) // ← ADD THIS LINE to match button width
    }

    private var isEmail: Bool {
        "\(fieldType)".lowercased().contains("email")
    }
}
