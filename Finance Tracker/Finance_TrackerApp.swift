//
//  Finance_TrackerApp.swift
//  Finance Tracker
//
//  Created by Osama Masoud on 19.11.2025.
//

import SwiftUI
import CoreData

@main
struct Finance_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
