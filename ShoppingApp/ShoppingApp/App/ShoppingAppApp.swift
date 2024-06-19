//
//  ShoppingAppApp.swift
//  ShoppingApp
//
//  Created by admin on 6/19/24.
//

import SwiftUI

@main
struct ShoppingAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
