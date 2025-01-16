import Foundation

public enum APIError: Error {
    case invalidURL
    case networkError(String)
    case invalidResponse
    case serverError(Int)
    case noData
    case decodingError(String)

    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .networkError(let message):
            return "Network error: \(message)"
        case .invalidResponse:
            return "Invalid response from the server."
        case .serverError(let code):
            return "Server error with status code: \(code)"
        case .noData:
            return "No data received from the server."
        case .decodingError(let message):
            return "Decoding error: \(message)"
        }
    }
}
