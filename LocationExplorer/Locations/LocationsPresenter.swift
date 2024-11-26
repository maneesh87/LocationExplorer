import Foundation

protocol LocationsPresenterProtocol {
    func presentLocations(_ locations: [Location]) async
    func presentError(_ error: Error) async
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
    
}
