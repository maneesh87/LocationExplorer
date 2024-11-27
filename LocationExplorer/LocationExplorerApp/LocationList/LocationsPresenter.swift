import Foundation
import SwiftUI

protocol LocationsPresenterProtocol {
    func presentLocations(_ locations: [Location]) async
    func presentError(_ error: Error) async
    func displayLocationDetails(_ location: Location)
}

class LocationsPresenter: LocationsPresenterProtocol {
    var view: LocationsViewProtocol?
    
    @MainActor
    func presentLocations(_ locations: [Location]) async {
        view?.displayLocations(locations)
    }
    
    @MainActor
    func presentError(_ error: any Error) async {
        view?.displayError(error)
    }
    
    func displayLocationDetails(_ location: Location) {
        openWikipedia(latitude: location.lat, longitude: location.long)
    }
    
    private func openWikipedia(latitude: Double, longitude: Double) {
        WikipediaAppUtility.openWikipedia(for: latitude, longitude: longitude)
    }
}
