import Foundation

class LocationsViewState: ObservableObject {
    enum State {
        case loading
        case loaded([Location])
        case error(String)
    }
    
    @Published var state: State = .loading
}
