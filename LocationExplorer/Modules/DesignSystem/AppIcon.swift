import Foundation
import SwiftUI

public enum AppIcon: String {
    case chevronRight = "chevron.right"
    case xmark = "xmark"
}

extension Image {
    static func appIcon(_ appIcon: AppIcon) -> Image {
        return Image(systemName: appIcon.rawValue)
    }
}
