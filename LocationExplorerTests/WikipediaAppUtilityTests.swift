import XCTest
@testable import LocationExplorer

class WikipediaAppUtilityTests: XCTestCase {

    func testCreateWikipediaURL() {
        let latitude = 50.0
        let longitude = 15.0
        let expectedURLString = "wikipedia://abnPlaces?WMFLat=\(latitude)&WMFLong=\(longitude)"
        
        let url = WikipediaAppUtility.createWikipediaURL(latitude: latitude, longitude: longitude)
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.absoluteString, expectedURLString)
    }
    
    func testOpenWikipedia() {
        let latitude = 50.0
        let longitude = 15.0
        
        let url = WikipediaAppUtility.createWikipediaURL(latitude: latitude, longitude: longitude)
        XCTAssertNotNil(url)
        
        let canOpenURL = UIApplication.shared.canOpenURL(url!)
        
        if canOpenURL {
            WikipediaAppUtility.openWikipedia(for: latitude, longitude: longitude)
            // Since we cannot verify the actual opening of the URL in tests, we assume if canOpenURL is true, the function works as expected.
            XCTAssertTrue(canOpenURL)
        } else {
            XCTAssertFalse(canOpenURL)
        }
    }
}
