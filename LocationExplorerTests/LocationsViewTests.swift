import XCTest
import SwiftUI
@testable import LocationExplorer

final class LocationsViewTests: XCTestCase {
    
    var view: LocationsView!
    var interactor: LocationsInteractor!
    var presenter: LocationsPresenter!
    
    override func setUp() {
        super.setUp()
        view = LocationsView()
        interactor = LocationsInteractor()
        presenter = LocationsPresenter()
        
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
    }
    
    override func tearDown() {
        view = nil
        interactor = nil
        presenter = nil
        super.tearDown()
    }
    
    func testDisplayLocations() {
        let locations = [Location(name: "Test Location", lat: 0.0, long: 0.0)]
        view.displayLocations(locations)
        
        XCTAssertEqual(view.viewState.state, .loaded(locations))
    }
    
    func testDisplayError() {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test Error"])
        view.displayError(error)
        
        XCTAssertEqual(view.viewState.state, .error("Test Error"))
    }
    
    func testLoadingStateOnAppear() {
        _ = view.onAppear()
        
        XCTAssertEqual(view.viewState.state, .loading)
    }
    
}
