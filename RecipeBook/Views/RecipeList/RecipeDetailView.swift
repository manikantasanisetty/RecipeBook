import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                // Recipe Image
                if let url = recipe.photoURLLarge {
                    CachedImageView(url: url)
                        .frame(height: 300)
                        .clipped()
                        .cornerRadius(10)
                } else {
                    Color.gray
                        .frame(height: 300)
                        .cornerRadius(10)
                }
                
                // Recipe Name
                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(nil)
                
                // Cuisine
                Text("Cuisine: \(recipe.cuisine)")
                    .font(.body)
                    .foregroundColor(.gray)
                
                // Source Hyperlink
                if let sourceURL = recipe.sourceURL {
                    Link("View Source", destination: sourceURL)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                
                // YouTube Hyperlink
                if let youtubeURL = recipe.youtubeURL {
                    Link("Watch recipe on YouTube", destination: youtubeURL)
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
            }
            .padding()
            .navigationTitle(recipe.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RecipeDetailView(
        recipe: Recipe(
            id: UUID(),
            name: "Banana Pancakes",
            cuisine: "American",
            photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"),
            photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg"),
            sourceURL: URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes"),
            youtubeURL: URL(string: "https://www.youtube.com/watch?v=kSKtb2Sv-_U")
        )
    )
}
