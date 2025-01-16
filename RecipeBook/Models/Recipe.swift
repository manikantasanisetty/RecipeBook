import Foundation

public struct RecipesResponse: Codable {
    public let recipes: [Recipe]
}

public struct Recipe: Identifiable, Codable {
    public let id: UUID
    public let name: String
    public let cuisine: String
    public let photoURLSmall: URL?
    public let photoURLLarge: URL?
    public let sourceURL: URL?
    public let youtubeURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name, cuisine
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}
