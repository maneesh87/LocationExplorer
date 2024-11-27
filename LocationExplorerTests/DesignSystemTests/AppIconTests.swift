import XCTest
import SwiftUI
@testable import LocationExplorer

class AppIconTests: XCTestCase {

    func testAppIconEnum() {
        XCTAssertEqual(AppIcon.chevronRight.rawValue, "chevron.right")
        XCTAssertEqual(AppIcon.xmark.rawValue, "xmark")
    }

    func testAppIconImage() {
        let chevronRightImage = Image.appIcon(.chevronRight)
        let xmarkImage = Image.appIcon(.xmark)
        
        XCTAssertEqual(chevronRightImage, Image(systemName: "chevron.right"))
        XCTAssertEqual(xmarkImage, Image(systemName: "xmark"))
    }
}
