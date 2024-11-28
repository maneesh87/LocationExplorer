import XCTest
import SwiftUI
@testable import LocationExplorer

final class CustomLocationViewTests: XCTestCase {
    var view: CustomLocationView!
    var interactor: CustomLocationInteractor!
    
    override func setUp() {
        super.setUp()
        interactor = CustomLocationInteractor()
        view = CustomLocationView(interactor: interactor)
    }
    
    override func tearDown() {
        view = nil
        interactor = nil
        super.tearDown()
    }
        
    func testDisplayError() {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test Error"])
        
        view.displayError(error)
        
        XCTAssertEqual(view.viewState.errorMessage, "Test Error")
    }
    
    func testDisplayCoordinates() {
        let latitude = "50.0"
        let longitude = "15.0"
        
        view.displayCoordinates(latitude: latitude, longitude: longitude)
        
        XCTAssertEqual(view.viewState.latitude, latitude)
        XCTAssertEqual(view.viewState.longitude, longitude)
    }
}
