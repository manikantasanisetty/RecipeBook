import Foundation
import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()
    @State private var selectedCuisine: String? = nil
    @State private var isLoading = false
    
    private let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 300), spacing: 16)
    ]
    
    var filteredRecipes: [Recipe] {
        if let selectedCuisine = selectedCuisine {
            return viewModel.recipes.filter { $0.cuisine == selectedCuisine }
        } else {
            return viewModel.recipes
        }
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    Group {
                        if let errorMessage = viewModel.errorMessage {
                            // Display error message
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        } else if filteredRecipes.isEmpty {
                            // Display empty state
                            Text("No recipes available.")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            // Grid layout for filtered recipes
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(filteredRecipes) { recipe in
                                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                        RecipeView(
                                            recipeName: recipe.name,
                                            cuisine: recipe.cuisine,
                                            imageURL: recipe.photoURLSmall
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding()
                        }
                    }
                }
                .navigationTitle("Recipes")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        filterMenu
                    }
                }
            }
            // Loading indicator overlay
            if isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .overlay(
                        ProgressView("Loading...")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.8))
                            .cornerRadius(10)
                    )
            }
        }
        .refreshable {
            // Refresh recipes on pull-to-refresh
            loadRecipes()
        }
        .onFirstAppear {
            // Load recipes on first appearance
            loadRecipes()
        }
    }
    
    private var filterMenu: some View {
        Menu {
            // "All Cuisines" option
            Button {
                selectedCuisine = nil
            } label: {
                HStack {
                    Text("All Cuisines")
                    if selectedCuisine == nil {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            // Cuisine-specific options
            ForEach(viewModel.cuisineTypes, id: \.self) { cuisine in
                Button {
                    selectedCuisine = cuisine
                } label: {
                    HStack {
                        Text(cuisine)
                        if selectedCuisine == cuisine {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            Label(
                selectedCuisine ?? "Filter",
                systemImage: "line.horizontal.3.decrease.circle"
            )
        }
    }
    
    private func loadRecipes() {
        isLoading = true
        Task {
            await viewModel.loadRecipes()
            isLoading = false
        }
    }
}
