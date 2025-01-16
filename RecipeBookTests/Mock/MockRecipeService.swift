import Foundation
@testable import RecipeBook

class MockRecipeService: RecipeServiceProtocol {
    private let recipes: [Recipe]
    private let shouldFail: Bool

    init(recipes: [Recipe] = [], shouldFail: Bool = false) {
        self.recipes = recipes
        self.shouldFail = shouldFail
    }

    func fetchRecipes() async throws -> [Recipe] {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        return recipes
    }
}
