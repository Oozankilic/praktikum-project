//
//  RecipesApp.swift
//  Recipes
//
//  Created by Ferhat Turhan on 14.10.2023.
//

import SwiftUI
import SwiftData

@main
struct RecipesApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: ShoppingList.self)
        } catch {
            fatalError("Could not initialise ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: ShoppingList.self)
        }
    }
}
