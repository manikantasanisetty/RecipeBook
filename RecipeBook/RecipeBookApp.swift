//
//  RecipeBookApp.swift
//  RecipeBook
//

import Networking
import SwiftUI

@main
struct RecipeBookApp: App {
    
    init() {
        NetworkManager.shared.configure(environment: .qa)
    }
    
    var body: some Scene {
        WindowGroup {
            RecipeListView()
        }
    }
}
