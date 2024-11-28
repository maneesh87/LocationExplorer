import SwiftUI

protocol LocationsViewProtocol {
    func displayLocations(_ locations: [Location])
    func displayError(_ error: Error)
}

struct LocationsView: View, LocationsViewProtocol {
    var interactor: LocationsInteractorProtocol?
    
    @ObservedObject var viewState = LocationsViewState()
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
                Text("Locations")
                    .font(.appFont(.headline))
                    .foregroundColor(.appColor(.primaryBrand))
                    .accessibility(hidden: true)
                
                List(locations, id: \.self) { location in
                    HStack {
                        VStack(alignment: .leading, spacing: CGFloat.spacing(.small)) {
                            Text(location.name ?? "Unknown")
                                .font(.appFont(.headlineBold))
                                .accessible(label: "Location", hint: "Tap to open wikipedia", value: location.name)

                            Text("Lat: \(location.lat), Long: \(location.long)")
                                .font(.appFont(.subheadline))
                                .accessibility(hidden: true)
                        }
                        Spacer()
                        Image.appIcon(.chevronRight)
                            .foregroundColor(.appColor(.primaryBrand))
                            .accessibility(hidden: true)
                    }
                    .onTapGesture {
                        interactor?.didSelectLocation(location)
                    }
                }
            case .error(let errorMessage):
                Text("Error: \(errorMessage)")
                    .foregroundColor(.appColor(.textError))
                    .accessible(label: "Error", value: errorMessage)
            }
            
            Button(action: {
                isPopupPresented = true
            }) {
                Text("Enter Location")
                    .foregroundColor(.appColor(.primaryForeground))
                    .padding()
                    .accessible(label: "Enter Location", hint: "Tap to enter coordinates")

            }
        }
        .onAppear {
            viewState.state = .loading
            interactor?.loadLocations()
        }
        .sheet(isPresented: $isPopupPresented) {
            CustomLocationFactory.createLocationView()
        }
    }
    
    func displayLocations(_ location: [Location]) {
        viewState.state = .loaded(location)
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
