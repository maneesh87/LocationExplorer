import XCTest
@testable import LocationExplorer

class MockLocationsView: LocationsViewProtocol {
    var displayedLocations: [Location]?
    var displayedError: Error?
    
    func displayLocations(_ Locations: [Location]) {
        displayedLocations = Locations
    }
    
    func displayError(_ error: Error) {
        displayedError = error
    }
}

final class LocationsPresenterTests: XCTestCase {
    
    var presenter: LocationsPresenter!
    var mockView: MockLocationsView!
    
    override func setUpWithError() throws {
        mockView = MockLocationsView()
        presenter = LocationsPresenter()
        presenter.view = mockView
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        mockView = nil
    }
    
    func testPresentLocations() async {
        // Given
        let expectedLocations = [Location(name: "Test Location", lat: 0.0, long: 0.0)]
                
        // When
        await presenter.presentLocations(expectedLocations)
                
        // Then
        XCTAssertEqual(mockView.displayedLocations, expectedLocations)
        XCTAssertNil(mockView.displayedError)
    }
    
    func testPresentError() async {
        // Given
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
                
        // When
        await presenter.presentError(expectedError)
                
        // Then
        XCTAssertEqual(mockView.displayedError as NSError?, expectedError)
        XCTAssertNil(mockView.displayedLocations)
    }
}
