import XCTest
@testable import LocationExplorer

class DecodableMapperTests: XCTestCase {
    func testDecoder() async throws {
        let data = try MockDataLoader().getData(fromJSON: "locations")
        let result: Locations = try await DecodableMapper.decode(result: data)
        XCTAssertTrue(result.locations.count == 4)
    }
    
    func testError() async throws {
        let data = Data()
        do {
            let _: Locations = try await DecodableMapper.decode(result: data)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual(error as? NetworkError, NetworkError.decodingError)
        }
    }
    
}
