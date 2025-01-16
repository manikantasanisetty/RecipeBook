import SwiftUI

public struct RecipeView: View {
    public let recipeName: String
    public let cuisine: String
    public let imageURL: URL?
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let imageURL = imageURL {
                CachedImageView(url: imageURL)
                    .frame(height: 100)
                    .clipped()
                    .cornerRadius(8)
            } else {
                Color.gray
                    .frame(height: 100)
                    .cornerRadius(8)
            }
            
            Text(recipeName)
                .font(.headline)
                .lineLimit(2, reservesSpace: true)
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    VStack(spacing: 16) {
        RecipeView(
            recipeName: "Banana Pancakes",
            cuisine: "American",
            imageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg")
        )
        
        // Invalid Image URL
        RecipeView(
            recipeName: "Banana Pancakes",
            cuisine: "American",
            imageURL: URL(string: "https://invalidurl.com/invalid")
        )
        
        // No Image URL
        RecipeView(
            recipeName: "Banana Pancakes",
            cuisine: "American",
            imageURL: nil
        )
    }
    .padding()
}
