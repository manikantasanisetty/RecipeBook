import XCTest
@testable import RecipeBook

class RecipeListViewModelTests: XCTestCase {

    func testLoadRecipesSuccess() async {
        // Given
        let mockRecipes = [
            Recipe(
                id: UUID(),
                name: "Banana Pancakes",
                cuisine: "American",
                photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"),
                photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg"),
                sourceURL: URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes"),
                youtubeURL: URL(string: "https://www.youtube.com/watch?v=kSKtb2Sv-_U")
            )
        ]
        let mockService = MockRecipeService(recipes: mockRecipes)
        let viewModel = RecipeListViewModel(recipeService: mockService)

        // When
        await viewModel.loadRecipes()

        // Then
        XCTAssertEqual(viewModel.recipes.count, 1)
        XCTAssertEqual(viewModel.recipes.first?.name, "Banana Pancakes")
    }

    func testLoadRecipesFailure() async {
        // Given
        let mockService = MockRecipeService(shouldFail: true)
        let viewModel = RecipeListViewModel(recipeService: mockService)

        // When
        await viewModel.loadRecipes()

        // Then
        XCTAssertEqual(viewModel.recipes.count, 0)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
