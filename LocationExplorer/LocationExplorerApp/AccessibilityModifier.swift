import SwiftUI

struct AccessibilityModifier: ViewModifier {
    var label: String
    var hint: String
    var value: String
    var isHidden: Bool = false
    
    func body(content: Content) -> some View {
        content
            .accessibilityLabel(label)
            .accessibilityHint(hint)
            .accessibilityValue(value)
            .accessibilityHidden(isHidden)
    }
}

extension View {
    func accessible(label: String? = nil, hint: String? = nil, value: String? = nil, isHidden: Bool = false) -> some View {
        self.modifier(
            AccessibilityModifier(label: label ?? "", hint: hint ?? "", value: value ?? "", isHidden: isHidden)
        )
    }
}
