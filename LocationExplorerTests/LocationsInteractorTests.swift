import XCTest
@testable import LocationExplorer

class MockAPIManager: APIManagerProtocol {
    var shouldReturnError = false
    var locationsResponse: Locations?
    
    func perform<Response>(route: Router) async throws -> Response where Response : Decodable {
        if shouldReturnError {
            throw NetworkError.requestFailed
        }
        guard let response = locationsResponse as? Response else {
            throw NetworkError.decodingError
        }
        return response
    }
}

class MockLocationsPresenter: LocationsPresenterProtocol {
    var presentedLocations: [Location]?
    var presentedError: Error?
    var selectedLocation: Location?
    
    func presentLocations(_ locations: [Location]) async {
        presentedLocations = locations
    }
    
    func presentError(_ error: Error) async {
        presentedError = error
    }
    
    func displayLocationDetails(_ location: LocationExplorer.Location) {
        selectedLocation = location
    }
}

final class LocationsInteractorTests: XCTestCase {
    
    var interactor: LocationsInteractor!
    var mockAPIManager: MockAPIManager!
    var mockPresenter: MockLocationsPresenter!
    
    override func setUpWithError() throws {
        mockAPIManager = MockAPIManager()
        mockPresenter = MockLocationsPresenter()
        interactor = LocationsInteractor(apiManager: mockAPIManager)
        interactor.presenter = mockPresenter
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        mockAPIManager = nil
        mockPresenter = nil
    }
    
    func testLoadLocationsSuccess() async throws {
        let expectedLocations = [Location(name: "Test Location", lat: 0.0, long: 0.0)]
        mockAPIManager.locationsResponse = Locations(locations: expectedLocations)
        let expectation = self.expectation(description: "LoadLocationsSuccess")
        
        Task {
            interactor.loadLocations()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 5)
        
        XCTAssertEqual(mockPresenter.presentedLocations, expectedLocations)
        XCTAssertNil(mockPresenter.presentedError)
    }
    
    func testLoadLocationsFailure() async throws {
        mockAPIManager.shouldReturnError = true
        let expectation = self.expectation(description: "LoadLocationsFailure")
        
        Task {
            interactor.loadLocations()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 5)
        
        XCTAssertNotNil(mockPresenter.presentedError)
        XCTAssertNil(mockPresenter.presentedLocations)
    }
    
    func testDidSelectLocation() {
        let testLocation = Location(name: "Test Location", lat: 0.0, long: 0.0)
        interactor.didSelectLocation(testLocation)
        
        XCTAssertEqual(mockPresenter.selectedLocation, testLocation)
    }
}

