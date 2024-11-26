import XCTest
@testable import LocationExplorer

class RouterURLRequestTests: XCTestCase {
    
    struct MockRouter: Router {
        var path: String {
            "/test"
        }
        var method: HTTPMethod {
            .get
        }
        var contentType: String {
            "application/json"
        }
        var body: Data? {
            "Test Body".data(using: .utf8)
        }
        
        var queryParameters: [String : Any]? {
            ["key1": "value1"]
        }
        
        var headers: [String : Any]? {
            ["Header1": "Value1", "Header2": "Value2"]
        }
    }
    
    func testCreateUrlRequestWithValidURL() throws {
        let router = MockRouter()
        let baseURL = "https://example.com"
        let bodyData = "Test Body".data(using: .utf8)
        
        let urlRequest = try router.createUrlRequest(withBaseURL: baseURL)
        
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://example.com/test?key1=value1")
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.httpBody, bodyData)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Header1"], "Value1")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Header2"], "Value2")
    }
}
