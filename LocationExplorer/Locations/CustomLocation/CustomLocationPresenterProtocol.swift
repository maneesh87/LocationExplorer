import Foundation
import UIKit
import CoreLocation

protocol CustomLocationPresenterProtocol {
    func displayRandomLocation(coordinates: CLLocationCoordinate2D)
    func displayError(_ error: Error)
    func openWikipedia(for latitude: Double, longitude: Double)
}

class customLocationPresenter: CustomLocationPresenterProtocol {
    var view: CustomLocationViewProtocol?
    
    func displayRandomLocation(coordinates: CLLocationCoordinate2D) {
        view?.displayCoordinates(latitude: "\(coordinates.latitude)", longitude: "\(coordinates.longitude)")
    }
    
    func displayError(_ error: Error) {
        view?.displayError(error)
    }
    
    func openWikipedia(for latitude: Double, longitude: Double) {
        let urlString = "wikipedia://abnPlaces?WMFLat=\(latitude)&WMFLong=\(longitude)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}

