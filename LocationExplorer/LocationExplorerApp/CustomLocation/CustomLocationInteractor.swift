import Foundation
import CoreLocation

protocol CustomLocationInteractorProtocol {
    func getRandomLocation()
    func submitCoordinates(lat: String, long: String)
}

class CustomLocationInteractor: CustomLocationInteractorProtocol {
    var presenter: CustomLocationPresenterProtocol?
    
    func getRandomLocation() {
        // Latitude range for Central Europe
        let randomLatitude = Double.random(in: 47.0...55.0)
        // Longitude range for Central Europe
        let randomLongitude = Double.random(in: 10.0...20.0)
        presenter?.displayRandomLocation(coordinates: CLLocationCoordinate2D(latitude: randomLatitude, longitude: randomLongitude))
    }
    
    func submitCoordinates(lat: String, long: String) {
        guard
            let lat = Double(lat),
            let long = Double(long),
            CLLocationCoordinate2DIsValid(CLLocationCoordinate2D(latitude: lat, longitude: long)) else {
            presenter?.displayError(ValidationError.invalidCoordinates)
            return
        }
        presenter?.openWikipedia(for: lat, longitude: long)
    }
    
}
