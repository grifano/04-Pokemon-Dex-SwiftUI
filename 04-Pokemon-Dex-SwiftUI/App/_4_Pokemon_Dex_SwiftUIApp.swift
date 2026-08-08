//
//  _4_Pokemon_Dex_SwiftUIApp.swift
//  04-Pokemon-Dex-SwiftUI
//
//  Created by sorlenko on 04/08/2026.
//

import SwiftUI
import CoreData

@main
struct _4_Pokemon_Dex_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
