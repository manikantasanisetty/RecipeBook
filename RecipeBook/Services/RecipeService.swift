import Foundation
import Networking

public protocol RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe]
}

public final class RecipeService: RecipeServiceProtocol {
    private let networkManager: NetworkManagerProtocol

    /// Initialize with a custom NetworkManager, useful for injecting mock network manager.
    public init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    /// Fetch recipes from the provided endpoint.
    public func fetchRecipes() async throws -> [Recipe] {
        let recipesResponse: RecipesResponse = try await networkManager.request(path: "recipes.json", method: .GET)
        return recipesResponse.recipes
    }
}
