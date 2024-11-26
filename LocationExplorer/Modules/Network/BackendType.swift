import Foundation

public enum Api: Equatable, Sendable {
    case prod
    case mock(String)
}

public enum BackendType {
    case prod
    case mock(String)

    public var baseURLString: String {
        switch self {
        case .prod:
            return "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/"
        case .mock(let baseURLString):
            return baseURLString
        }
    }
}
