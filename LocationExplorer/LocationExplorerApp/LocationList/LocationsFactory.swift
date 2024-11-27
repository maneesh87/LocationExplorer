import Foundation
import SwiftUI

struct LocationsViewFactory {
    static func createLocationsView() -> some View {
        let interactor = LocationsInteractor()
        let presenter = LocationsPresenter()
        
        let view = LocationsView(interactor: interactor)
        interactor.presenter = presenter
        presenter.view = view
        
        return view
    }
}
