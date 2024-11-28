import Foundation

class LocationsViewState: ObservableObject {
    enum State: Equatable {
        case loading
        case loaded([Location])
        case error(String)
    }
    
    @Published var state: State = .loading
}
