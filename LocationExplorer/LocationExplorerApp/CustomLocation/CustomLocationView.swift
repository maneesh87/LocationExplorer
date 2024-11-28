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
                    .keyboardType(.numbersAndPunctuation)
                    .accessible(label: "Latitude", hint: "Enter latitude value")
                
                TextField("Longitude", text: $viewState.longitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numbersAndPunctuation)
                    .accessible(label: "Longitude", hint: "Enter longitude value")
                
                if let errorMessage = viewState.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.appColor(.textError))
                        .accessible(label: "Error message", value: errorMessage)
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
                .accessible(label: "Submit button", hint: "Tap to open coordinates in wikipedia")
                
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
                .accessible(label: "Generate random coordinates button", hint: "Tap to generate random coordinates")
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Enter coordinates", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image.appIcon(.xmark)
                    .foregroundColor(.appColor(.primaryBrand))
                    .accessible(label: "Close button", hint: "Tap to close the view")
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
