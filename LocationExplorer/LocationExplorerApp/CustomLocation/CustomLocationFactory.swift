import Foundation
import SwiftUI

struct CustomLocationFactory {
    static func createLocationView() -> some View {
        let interactor = CustomLocationInteractor()
        let presenter = CustomLocationPresenter()
        
        let view = CustomLocationView(interactor: interactor)
        interactor.presenter = presenter
        presenter.view = view
        
        return view
    }
}
