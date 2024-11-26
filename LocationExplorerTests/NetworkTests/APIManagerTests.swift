import Foundation
import XCTest
@testable import LocationExplorer

class MockDispatcher: Dispatcher {
    func execute(backendType: BackendType, route: any Router) async throws -> Data {
        guard let fileURL = Bundle(for: type(of: self)).url(forResource: backendType.baseURLString, withExtension: "json") else {
            throw MockError.fileNotFound
        }

        do {
            return try MockDataLoader().getData(fromJSON: backendType.baseURLString)
        } catch {
            throw MockError.dataReadingFailed
        }
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
