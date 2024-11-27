import SwiftUI

@main
struct LocationExplorerApp: App {
    var body: some Scene {
        WindowGroup {            
            LocationsViewFactory.createLocationsView()
        }
    }
}
