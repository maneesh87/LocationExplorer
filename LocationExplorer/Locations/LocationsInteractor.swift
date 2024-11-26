import Foundation

protocol LocationsInteractorProtocol {
    func loadLocations()
}

class LocationsInteractor: LocationsInteractorProtocol {
    var presenter: LocationsPresenterProtocol?
    let apiManager: APIManagerProtocol

    init(apiManager: APIManagerProtocol = APIManager(backendType: .prod, dispatcher: URLSessionDispatcher())) {
        self.apiManager = apiManager
    }
    
    func loadLocations() {
        Task {
            do {
//                 await Task.sleep(2_000_000_000)
                try await fetchLocations()
            } catch {
                await presenter?.presentError(error)
            }
        }
    }
    
    private func fetchLocations() async throws {
        let locationResponse: Locations = try await apiManager.perform(route: LocationsAPIRouter.getLocations)
        await presenter?.presentLocations(locationResponse.locations)
    }
}
