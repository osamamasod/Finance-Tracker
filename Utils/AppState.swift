//
//  AppState.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 21.11.2025.
//


import Foundation
import Combine

final class AppState: ObservableObject {
    @Published var isAuthenticated: Bool = false
}