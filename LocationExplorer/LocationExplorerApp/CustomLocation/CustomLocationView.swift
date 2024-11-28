import SwiftUI

protocol CustomLocationViewProtocol {
    func displayError(_ error: Error)
    func displayCoordinates(latitude: String, longitude: String)
}

struct CustomLocationView: View, CustomLocationViewProtocol {
    var interactor: CustomLocationInteractorProtocol
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewState = CustomLocationViewState()
    
    var body: some View {
        NavigationView {
            VStack(spacing: CGFloat.spacing(.large)) {
                TextField("Latitude", text: $viewState.latitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Longitude", text: $viewState.longitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let errorMessage = viewState.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.appColor(.textError))
                }
                
                Button(action: {
                    viewState.errorMessage = nil
                    interactor.submitCoordinates(lat: viewState.latitude, long: viewState.longitude)
                }) {
                    Text("Submit")
                        .frame(maxWidth:.infinity)
                        .padding()
                        .background(Color.appColor(.secondaryBackground))
                        .foregroundColor(.appColor(.primaryForeground))
                        .cornerRadius(8)
                }
                
                Button(action: {
                    viewState.errorMessage = nil
                    interactor.getRandomLocation()
                }) {
                    Text("Generate random coordinates")
                        .frame(maxWidth:.infinity)
                        .padding()
                        .background(Color.appColor(.secondaryBackground))
                        .foregroundColor(.appColor(.primaryForeground))
                        .cornerRadius(.appCornerRadius)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Enter coordinates", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image.appIcon(.xmark)
                    .foregroundColor(.appColor(.primaryBrand))
            })
        }
        
    }
    
    func displayError(_ error: any Error) {
        viewState.errorMessage = error.localizedDescription
    }
    
    func displayCoordinates(latitude: String, longitude: String) {
        viewState.latitude = latitude
        viewState.longitude = longitude
    }
    
}

#Preview {
    CustomLocationView(interactor: CustomLocationInteractor())
}
