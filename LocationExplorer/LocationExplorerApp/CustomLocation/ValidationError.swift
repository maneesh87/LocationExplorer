import Foundation

enum ValidationError: Error, Equatable {
    case invalidCoordinates
}

extension ValidationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidCoordinates:
            return "Invalid coordinates"
        }
    }
}
