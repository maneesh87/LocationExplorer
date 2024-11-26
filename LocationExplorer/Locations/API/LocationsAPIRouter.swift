import Foundation

enum LocationsAPIRouter {
    case getLocations //https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json
}

extension LocationsAPIRouter: Router {
    var path: String {
        "main/locations.json"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryParameters: [String : Any]? {
        return nil
    }
}
