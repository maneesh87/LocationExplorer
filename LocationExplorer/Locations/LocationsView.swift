import SwiftUI

protocol LocationsViewProtocol {
    func displayLocations(_ locations: [Location])
    func displayError(_ error: Error)
}

struct LocationsView: View, LocationsViewProtocol {
    @ObservedObject private var viewState = LocationsViewState()
    
    var interactor: LocationsInteractorProtocol?
    
    var body: some View {
        VStack {
            switch viewState.state {
            case .loading:
                ProgressView("Loading...")
            case .loaded(let locations):
                List(locations, id: \.self) { location in
                    VStack(alignment: .leading) {
                        Text(location.name ?? "Unknown")
                            .font(.headline)
                        Text("Lat: \(location.lat), Long: \(location.long)")
                            .font(.subheadline)
                    }
                }
            case .error(let errorMessage):
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            viewState.state = .loading
            interactor?.loadLocations()
        }
    }
    
    func displayLocations(_ homework: [Location]) {
        viewState.state = .loaded(homework)
    }
    
    func displayError(_ error: any Error) {
        viewState.state = .error(error.localizedDescription)
    }
    
}

#Preview {
    var view = LocationsView()
    let interactor = LocationsInteractor()
    let presenter = LocationsPresenter()
    
    view.interactor = interactor
    interactor.presenter = presenter
    presenter.view = view
    
    return view
}
