import SwiftUI

protocol CustomLocationViewProtocol {
    func displayError(_ error: Error)
    func displayCoordinates(latitude: String, longitude: String)
}

class CustomLocationInputViewState: ObservableObject {
    @Published var errorMessage: String?
    @Published var textField1: String = ""
    @Published var textField2: String = ""
}

struct CustomLocationInputView: View, CustomLocationViewProtocol {
    var interactor: CustomLocationInteractorProtocol
    
    @Binding var isPresented: Bool
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewState = CustomLocationInputViewState()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Enter locations coordinates")
                    .font(.appFont(.headline))
                    .foregroundColor(.appColor(.primaryBrand))
                    .padding(.bottom)
                    .frame(alignment: .leading)
                
                VStack(spacing: CGFloat.spacing(.large)) {
                    
                    TextField("Latitude", text: $viewState.textField1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Longitude", text: $viewState.textField2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    if let errorMessage = viewState.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.appColor(.textError))
                    }
                    
                    Button(action: {
                        viewState.errorMessage = nil
                        interactor.submitCoordinates(lat: viewState.textField1, long: viewState.textField2)
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
                        interactor.getCustomLocation()
                    }) {
                        Text("Select random coordinates")
                            .frame(maxWidth:.infinity)
                            .padding()
                            .background(Color.appColor(.secondaryBackground))
                            .foregroundColor(.appColor(.primaryForeground))
                            .cornerRadius(8)
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.appColor(.primaryBrand))
                
            })
        }
        
    }
    
    func displayError(_ error: any Error) {
        viewState.errorMessage = error.localizedDescription
    }
    
    func displayCoordinates(latitude: String, longitude: String) {
        viewState.textField1 = latitude
        viewState.textField2 = longitude
    }
    
}

#Preview {
    CustomLocationInputView(interactor: CustomLocationInteractor(), isPresented: .constant(true))
}
