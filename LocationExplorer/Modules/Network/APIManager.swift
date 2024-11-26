import Foundation

public protocol APIManagerProtocol {
    func perform<Response: Decodable>(route: Router) async throws -> Response
}


public class APIManager: APIManagerProtocol {
    
    private var backendType: BackendType
    private var dispatcher: Dispatcher

    public init(backendType: BackendType, dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        self.backendType = backendType
    }
    
    public func perform<Response: Decodable>(route: Router) async throws -> Response {
        let data = try await execute(route: route)
        return try await DecodableMapper.decode(result: data)
    }
    
    private func execute(route: Router) async throws -> Data {
        return try await dispatcher.execute(
            backendType: backendType,
            route: route
        )
    }
    
}
