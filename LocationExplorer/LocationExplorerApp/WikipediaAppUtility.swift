import Foundation
import UIKit

class WikipediaAppUtility {
    static func createWikipediaURL(latitude: Double, longitude: Double) -> URL? {
        let urlString = "wikipedia://abnPlaces?WMFLat=\(latitude)&WMFLong=\(longitude)"
        return URL(string: urlString)
    }
    
    static func openWikipedia(for latitude: Double, longitude: Double) {
        if let url = WikipediaAppUtility.createWikipediaURL(latitude: latitude, longitude: longitude), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
