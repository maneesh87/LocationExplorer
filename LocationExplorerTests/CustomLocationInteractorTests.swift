import XCTest
import CoreLocation
@testable import LocationExplorer

class CustomLocationPresenterMock: CustomLocationPresenterProtocol {
    var coordinates: CLLocationCoordinate2D?
    var error: ValidationError?
    var lat: Double?
    var long: Double?
    
    func displayRandomLocation(coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
    }
    
    func displayError(_ error: any Error) {
        self.error = error as? ValidationError
    }
    
    func openWikipedia(for lat: Double, longitude long: Double) {
        self.lat = lat
        self.long = long
    }
}

class CustomLocationInteractorTests: XCTestCase {
    
    var interactor: CustomLocationInteractor!
    var presenterMock: CustomLocationPresenterMock!
    
    override func setUp() {
        super.setUp()
        interactor = CustomLocationInteractor()
        presenterMock = CustomLocationPresenterMock()
        interactor.presenter = presenterMock
    }
    
    override func tearDown() {
        interactor = nil
        presenterMock = nil
        super.tearDown()
    }
    
    func testGetRandomLocation() {
        interactor.getRandomLocation()
        
        XCTAssertNotNil(presenterMock.coordinates)
        XCTAssertTrue((47.0...55.0).contains(presenterMock.coordinates!.latitude))
        XCTAssertTrue((10.0...20.0).contains(presenterMock.coordinates!.longitude))
    }
    
    func testSubmitCoordinatesWithValidCoordinates() {
        interactor.submitCoordinates(lat: "50.0", long: "15.0")
        
        XCTAssertNil(presenterMock.error)
        XCTAssertEqual(presenterMock.lat, 50.0)
        XCTAssertEqual(presenterMock.long, 15.0)
    }
    
    func testSubmitCoordinatesWithInvalidCoordinates() {
        interactor.submitCoordinates(lat: "invalid", long: "invalid")
        
        XCTAssertNotNil(presenterMock.error)
        XCTAssertEqual(presenterMock.error, ValidationError.invalidCoordinates)
    }
}
