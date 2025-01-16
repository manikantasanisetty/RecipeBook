import Foundation

class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String? = nil
    
    var cuisineTypes: [String] {
        Set(recipes.map { $0.cuisine }).sorted()
    }
    
    private let recipeService: RecipeServiceProtocol
    public init(recipeService: RecipeServiceProtocol = RecipeService()) {
        self.recipeService = recipeService
    }
    
    @MainActor
    func loadRecipes() async {
        do {
            recipes = try await recipeService.fetchRecipes()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
