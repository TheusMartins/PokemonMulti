//
//  Themable.swift
//
//
//  Created by Scizor on 5/2/24.
//

import UIKit

protocol Themable {
    var brandColors: BrandColorsRepresentable { get }
    var backgroundColors: BackgroundColorsRepresentable { get }
    var textColors: TextColorsRepresentable { get }
}

/// Represents the Brand colors defined in Design System
public protocol BrandColorsRepresentable {
    var pikachuYellow: UIColor { get }
    var pokeballRed: UIColor { get }
}

/// Represents the Background colors defined in Design System
public protocol BackgroundColorsRepresentable {
    var backgroundColor: UIColor { get }
}

/// Represents the Status colors defined in Design System
public protocol TextColorsRepresentable {
    var background: UIColor { get }
    var textPrimary: UIColor { get }
    var textSecondary: UIColor { get }
    var border: UIColor { get }
    var elementBackground: UIColor { get }
    var textTertiary: UIColor { get }
    var textDisabled: UIColor { get }
}
