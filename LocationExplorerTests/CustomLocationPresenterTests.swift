import XCTest
import CoreLocation
@testable import LocationExplorer

class MockCustomLocationView: CustomLocationViewProtocol {
    var latitude: String?
    var longitude: String?
    var error: Error?
    
    func displayCoordinates(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func displayError(_ error: Error) {
        self.error = error
    }
}

class CustomLocationPresenterTests: XCTestCase {
    
    var presenter: CustomLocationPresenter!
    var mockView: MockCustomLocationView!
    
    override func setUp() {
        super.setUp()
        presenter = CustomLocationPresenter()
        mockView = MockCustomLocationView()
        presenter.view = mockView
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        super.tearDown()
    }
    
    func testDisplayRandomLocation() {
        let coordinates = CLLocationCoordinate2D(latitude: 50.0, longitude: 15.0)
        presenter.displayRandomLocation(coordinates: coordinates)
        
        XCTAssertEqual(mockView.latitude, "50.0")
        XCTAssertEqual(mockView.longitude, "15.0")
    }
    
    func testDisplayError() {
        let error = NSError(domain: "TestError", code: 1, userInfo: nil)
        presenter.displayError(error)
        
        XCTAssertEqual(mockView.error as NSError?, error)
    }
    
    func testOpenWikipedia() {
        let latitude = 50.0
        let longitude = 15.0
        let urlString = "wikipedia://abnPlaces?WMFLat=\(latitude)&WMFLong=\(longitude)"
        
        let url = URL(string: urlString)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
        XCTAssertTrue(UIApplication.shared.canOpenURL(url))
    }
}
