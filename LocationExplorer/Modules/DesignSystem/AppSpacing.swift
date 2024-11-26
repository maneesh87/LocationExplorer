import Foundation

public enum AppSpacing {
    case small
    case medium
    case large
}

public extension CGFloat {
    static func spacing(_ appSpacing: AppSpacing) -> CGFloat {
        switch appSpacing {
        case .small:
            return 4
        case .medium:
            return 8
        case .large:
            return 16
        }
    }
}
