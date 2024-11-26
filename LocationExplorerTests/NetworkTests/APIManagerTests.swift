import Foundation
import XCTest
@testable import LocationExplorer

class MockDispatcher: Dispatcher {
    func execute(backendType: BackendType, route: any Router) async throws -> Data {
        return try MockDataLoader().getData(fromJSON: backendType.baseURLString)
    }
}

struct MockRouter: Router {
    var path: String = "locations"
    var method: LocationExplorer.HTTPMethod = .get
}

class APIManagerTests: XCTestCase {
    
    func testAPIManagerSuccess() async throws {
        let dispacher = MockDispatcher()
        let apiManager = APIManager(backendType: .mock("locations"), dispatcher: dispacher)
        let data: Locations = try await apiManager.perform(route: MockRouter())
        XCTAssertNotNil(data)
    }
    
    func testAPIManagerError() async throws {
        let dispacher = MockDispatcher()
        let apiManager = APIManager(backendType: .mock("locations1"), dispatcher: dispacher)
        do {
            let _: Locations = try await apiManager.perform(route: MockRouter())
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error as? MockError == MockError.fileNotFound)
        }
    }
}
