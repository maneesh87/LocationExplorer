import XCTest
@testable import LocationExplorer

class AppCornerRadiusTests: XCTestCase {

    func testAppCornerRadius() {
        XCTAssertEqual(CGFloat.appCornerRadius, 8, "appCornerRadius should be 8")
    }
}
