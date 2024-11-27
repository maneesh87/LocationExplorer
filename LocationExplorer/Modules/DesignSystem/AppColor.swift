import SwiftUI

public enum AppColor: String {
    case primaryBackground = "primaryBackground"
    case secondaryBackground = "secondaryBackground"
    case primaryBrand = "primaryBrand"
    case primaryForeground = "primaryForeground"
    case textError = "textError"
}

public extension Color {
    static func appColor(_ appColors: AppColor) -> Color {
        return Color(appColors.rawValue)
    }
}
