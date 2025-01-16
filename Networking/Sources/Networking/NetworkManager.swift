import Foundation

// MARK: - HTTP Method Enum
public enum HTTPMethod: String {
    case GET, POST, PUT, DELETE, PATCH
}

public protocol NetworkManagerProtocol {
    func request<T: Decodable>(
        path: String,
        method: HTTPMethod,
        headers: [String: String],
        body: Data?
    ) async throws -> T
}

public extension NetworkManagerProtocol {
    func request<T: Decodable>(
        path: String,
        method: HTTPMethod,
        headers: [String: String] = [:],
        body: Data? = nil
    ) async throws -> T {
        try await request(path: path, method: method, headers: headers, body: body)
    }
}

// MARK: - Network Manager
public final class NetworkManager: @unchecked Sendable, NetworkManagerProtocol {
    
    public static let shared = NetworkManager()

    private var environment: Environment
    private let urlSession: URLSession

    private init(environment: Environment = .qa, urlSession: URLSession = .shared) {
        self.environment = environment
        self.urlSession = urlSession
    }

    public func configure(environment: Environment) {
        self.environment = environment
    }

    private func buildURL(path: String) -> URL? {
        return URL(string: environment.baseURL)?.appendingPathComponent(path)
    }

    public func request<T>(
        path: String,
        method: HTTPMethod,
        headers: [String : String] = [:],
        body: Data? = nil
    ) async throws -> T where T : Decodable {
        guard let url = buildURL(path: path) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.httpBody = body

        let (data, response) = try await urlSession.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(httpResponse.statusCode)
        }

        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw APIError.decodingError(error.localizedDescription)
        }
    }
}
