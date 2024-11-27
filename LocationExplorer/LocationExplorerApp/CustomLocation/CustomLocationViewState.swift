import Foundation

class CustomLocationViewState: ObservableObject {
    @Published var errorMessage: String?
    @Published var latitude: String = ""
    @Published var longitude: String = ""
}
