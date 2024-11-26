import Foundation

public class URLSessionDispatcher: Dispatcher {
    private var session: URLSession
    
    public init() {
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    public func execute(backendType: BackendType, route: any Router) async throws -> Data {
        guard let request = try? route.createUrlRequest(withBaseURL: backendType.baseURLString) else {
            throw NetworkError.invalidRequest
        }
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.requestFailed
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return data
        default:
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
    }
}
