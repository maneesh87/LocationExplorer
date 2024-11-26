import Foundation

public typealias APIRequestCompletion = ((Result<Data, Error>) -> ())

public protocol Dispatcher {
    func execute(backendType: BackendType, route: Router) async throws -> Data
}
