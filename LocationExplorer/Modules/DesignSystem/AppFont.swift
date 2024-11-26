import Foundation
import SwiftUI

public enum AppFont {
    case headlineBold
    case headline
    case subheadline
    case body
}

public extension Font {
    static func appFont(_ appFont: AppFont) -> Font {
        switch appFont {
        case .headlineBold:
            return Font.custom("Helvetica-Bold", size: 16, relativeTo: .headline)
        case .headline:
            return Font.custom("Helvetica", size: 16, relativeTo: .headline)
        case .subheadline:
            return Font.custom("Helvetica", size: 14, relativeTo: .subheadline)
        case .body:
            return Font.custom("Helvetica", size: 12, relativeTo: .body)

        }
    }
}
