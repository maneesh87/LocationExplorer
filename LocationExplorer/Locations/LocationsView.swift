import SwiftUI

protocol LocationsViewProtocol {
    func displayLocations(_ locations: [Location])
    func displayError(_ error: Error)
}

struct LocationsView: View, LocationsViewProtocol {
    @ObservedObject private var viewState = LocationsViewState()
    
    var interactor: LocationsInteractorProtocol?
    @State private var isPopupPresented: Bool = false
    
    var body: some View {
        VStack {
            switch viewState.state {
            case .loading:
                ProgressView("Loading Locations")
                    .tint(.appColor(.primaryBrand))
                    .foregroundColor(Color.appColor(.primaryForeground))
                    .font(.appFont(.headline))
                
            case .loaded(let locations):
                Text("Homework Locations")
                    .font(.appFont(.headline))
                    .foregroundColor(.appColor(.primaryBrand))
                
                List(locations, id: \.self) { location in
                    HStack {
                        VStack(alignment: .leading, spacing: CGFloat.spacing(.small)) {
                            Text(location.name ?? "Unknown")
                                .font(.appFont(.headlineBold))
                            Text("Lat: \(location.lat), Long: \(location.long)")
                                .font(.appFont(.subheadline))
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.appColor(.primaryBrand))
                    }
                    .onTapGesture {
                        interactor?.didSelectLocation(location)
                    }
                }
            case .error(let errorMessage):
                Text("Error: \(errorMessage)")
                    .foregroundColor(.appColor(.textError))
            }
            
            Button(action: {
                isPopupPresented = true
            }) {
                Text("Enter Location")
                    .foregroundColor(.blue)
            }
        }
        .onAppear {
            viewState.state = .loading
            interactor?.loadLocations()
        }
        .sheet(isPresented: $isPopupPresented) {
            let presenter = customLocationPresenter()
            let customLocationInteractor = CustomLocationInteractor()
            let view = CustomLocationInputView(
                interactor: customLocationInteractor,
                isPresented: $isPopupPresented
            )
            customLocationInteractor.presenter = presenter
            presenter.view = view
            return view
                        
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
