import Foundation

public protocol Router {
    var path: String  { get }
    var method: HTTPMethod  { get }
    var contentType: String { get }
    var body: Data? { get }
    var queryParameters: [String: Any]? { get }
    var headers: [String: Any]? { get }
}

public extension Router {

    var contentType: String {
        "application/json"
    }

    var body: Data? {
        nil
    }

    var queryParameters: [String: Any]? {
        nil
    }
    
    var headers: [String: Any]? {
        nil
    }

}
