//
//  SwiftUIThemable.swift
//
//
//  Created by Scizor on 6/12/24.
//

import SwiftUI

protocol SwiftUIThemable {
    var brandColors: SwiftUIBrandColorsRepresentable { get }
    var backgroundColors: SwiftUIBackgroundColorsRepresentable { get }
    var textColors: SwiftUITextColorsRepresentable { get }
}

/// Represents the Brand colors defined in Design System
public protocol SwiftUIBrandColorsRepresentable {
    var pikachuYellow: Color { get }
    var pokeballRed: Color { get }
}

/// Represents the Background colors defined in Design System
public protocol SwiftUIBackgroundColorsRepresentable {
    var backgroundColor: Color { get }
}

/// Represents the Status colors defined in Design System
public protocol SwiftUITextColorsRepresentable {
    var background: Color { get }
    var textPrimary: Color { get }
    var textSecondary: Color { get }
    var border: Color { get }
    var elementBackground: Color { get }
    var textTertiary: Color { get }
    var textDisabled: Color { get }
}
