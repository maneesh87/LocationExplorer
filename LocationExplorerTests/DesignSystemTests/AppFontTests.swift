import XCTest
import SwiftUI
@testable import LocationExplorer

class AppFontTests: XCTestCase {

    func testHeadlineBoldFont() {
        let font = Font.appFont(.headlineBold)
        XCTAssertEqual(font, Font.custom("Helvetica-Bold", size: 16, relativeTo: .headline))
    }

    func testHeadlineFont() {
        let font = Font.appFont(.headline)
        XCTAssertEqual(font, Font.custom("Helvetica", size: 16, relativeTo: .headline))
    }

    func testSubheadlineFont() {
        let font = Font.appFont(.subheadline)
        XCTAssertEqual(font, Font.custom("Helvetica", size: 14, relativeTo: .subheadline))
    }

    func testBodyFont() {
        let font = Font.appFont(.body)
        XCTAssertEqual(font, Font.custom("Helvetica", size: 12, relativeTo: .body))
    }
}
