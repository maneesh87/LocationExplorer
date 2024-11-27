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
        openWikipedia(for: location.name, latitude: location.lat, longitude: location.long)
    }
    
    private func openWikipedia(for locationName: String?, latitude: Double, longitude: Double) {
        let urlString = "wikipedia://abnPlaces?WMFLat=\(latitude)&WMFLong=\(longitude)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
