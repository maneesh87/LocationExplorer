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
        let expectedLocations = [Location(name: "Test Location", lat: 0.0, long: 0.0)]
                
        await presenter.presentLocations(expectedLocations)
                
        XCTAssertEqual(mockView.displayedLocations, expectedLocations)
        XCTAssertNil(mockView.displayedError)
    }
    
    func testPresentError() async {
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
                
        await presenter.presentError(expectedError)
                
        XCTAssertEqual(mockView.displayedError as NSError?, expectedError)
        XCTAssertNil(mockView.displayedLocations)
    }
}
