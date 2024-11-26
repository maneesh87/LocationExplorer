import SwiftUI

@main
struct LocationExplorerApp: App {
    var body: some Scene {
        WindowGroup {            
            let interactor = LocationsInteractor()
            let presenter = LocationsPresenter()
            
            let view = LocationsView(interactor: interactor)
            interactor.presenter = presenter
            presenter.view = view
            
            return view
        }
    }
}
