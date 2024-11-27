import XCTest
import SwiftUI
@testable import LocationExplorer

class AppColorTests: XCTestCase {

    func testAppColorPrimaryBackground() {
        let color = Color.appColor(.primaryBackground)
        XCTAssertEqual(color, Color("primaryBackground"))
    }

    func testAppColorSecondaryBackground() {
        let color = Color.appColor(.secondaryBackground)
        XCTAssertEqual(color, Color("secondaryBackground"))
    }

    func testAppColorPrimaryBrand() {
        let color = Color.appColor(.primaryBrand)
        XCTAssertEqual(color, Color("primaryBrand"))
    }

    func testAppColorPrimaryForeground() {
        let color = Color.appColor(.primaryForeground)
        XCTAssertEqual(color, Color("primaryForeground"))
    }

    func testAppColorTextError() {
        let color = Color.appColor(.textError)
        XCTAssertEqual(color, Color("textError"))
    }
}