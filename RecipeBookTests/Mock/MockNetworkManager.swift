import Foundation
import Networking

class MockNetworkManager: NetworkManagerProtocol {
    private let data: Data
    private let shouldFail: Bool

    init(data: Data, shouldFail: Bool = false) {
        self.data = data
        self.shouldFail = shouldFail
    }

    func request<T>(path: String, method: Networking.HTTPMethod, headers: [String : String], body: Data?) async throws -> T where T : Decodable {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
