import Foundation
import UIKit
import CoreLocation

protocol CustomLocationPresenterProtocol {
    func displayRandomLocation(coordinates: CLLocationCoordinate2D)
    func displayError(_ error: Error)
    func openWikipedia(for latitude: Double, longitude: Double)
}

class CustomLocationPresenter: CustomLocationPresenterProtocol {
    var view: CustomLocationViewProtocol?
    
    func displayRandomLocation(coordinates: CLLocationCoordinate2D) {
        let latitude = String(coordinates.latitude)
        let longitude = String(coordinates.longitude)
        view?.displayCoordinates(latitude: latitude, longitude: longitude)
    }
    
    func displayError(_ error: Error) {
        view?.displayError(error)
    }
    
    func openWikipedia(for latitude: Double, longitude: Double) {
        WikipediaAppUtility.openWikipedia(for: latitude, longitude: longitude)
    }
    
}

