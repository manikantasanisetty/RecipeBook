import XCTest
@testable import RecipeBook

final class RecipeServiceTests: XCTestCase {

    func testFetchRecipesSuccess() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager(data: """
        {
            "recipes": [
                {
                    "uuid": "f8b20884-1e54-4e72-a417-dabbc8d91f12",
                    "name": "Banana Pancakes",
                    "cuisine": "American",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/banana-pancakes",
                    "youtube_url": "https://www.youtube.com/watch?v=kSKtb2Sv-_U"
                }
            ]
        }
        """.data(using: .utf8)!)

        let recipeService = RecipeService(networkManager: mockNetworkManager)

        // When
        let recipes = try await recipeService.fetchRecipes()

        // Then
        XCTAssertEqual(recipes.count, 1)
        XCTAssertEqual(recipes.first?.name, "Banana Pancakes")
        XCTAssertEqual(recipes.first?.cuisine, "American")
    }

    func testFetchRecipesMalformedData() async {
        // Given
        let mockNetworkManager = MockNetworkManager(data: """
        {
            "invalid_key": "some_value"
        }
        """.data(using: .utf8)!)

        let recipeService = RecipeService(networkManager: mockNetworkManager)

        // When/Then
            do {
                _ = try await recipeService.fetchRecipes()
                XCTFail("Expected decoding error, but no error was thrown.")
            } catch {
                XCTAssertTrue(true)
            }
    }
}
