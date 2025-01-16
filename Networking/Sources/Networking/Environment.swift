import Foundation

/// Enum representing different environments
public enum Environment {
    case qa
    case staging
    case production

    /// Base URL for each environment
    public var baseURL: String {
        switch self {
        case .qa:
            return "https://d3jbb8n5wk0qxi.cloudfront.net/"
        case .staging:
            return "https://d3jbb8n5wk0qxi.cloudfront.net/"
        case .production:
            return "https://d3jbb8n5wk0qxi.cloudfront.net/"
        }
    }
}
