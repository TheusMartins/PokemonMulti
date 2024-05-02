//
//  Colors.swift
//
//
//  Created by Scizor on 5/2/24.
//

import UIKit

struct BrandLightColors: BrandColorsRepresentable {
    var pikachuYellow: UIColor = UIColor(red: 0.992, green: 0.796, blue: 0.192, alpha: 1)
    var pokeballRed: UIColor = UIColor(red: 0.929, green: 0.106, blue: 0.141, alpha: 1)
}

struct BackgroundLightColors: BackgroundColorsRepresentable {
    var backgroundColor: UIColor = UIColor(red: 0.980, green: 0.980, blue: 0.988, alpha: 1.0)
}

struct TextLightColors: TextColorsRepresentable {
    var background: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha:1)
    var textPrimary: UIColor = UIColor(red: 0.251, green: 0.251, blue: 0.251, alpha:1)
    var textSecondary: UIColor = UIColor(red: 0.051, green: 0.051, blue: 0.051, alpha:1)
    var border: UIColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha:1)
    var elementBackground: UIColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha:1)
    var textTertiary: UIColor = UIColor(red: 0.451, green: 0.451, blue: 0.451, alpha:1)
    var textDisabled: UIColor = UIColor(red: 0.667, green: 0.667, blue: 0.667, alpha:1)
}

struct BrandDarkColors: BrandColorsRepresentable {
    var pikachuYellow: UIColor = UIColor(red: 0.992, green: 0.796, blue: 0.192, alpha: 1)
    var pokeballRed: UIColor = UIColor(red: 0.929, green: 0.106, blue: 0.141, alpha: 1)
}

struct BackgroundDarkColors: BackgroundColorsRepresentable {
    var backgroundColor: UIColor = UIColor(red: 0.098, green: 0.118, blue: 0.137, alpha: 1.0)
}

struct TextDarkColors: TextColorsRepresentable {
    var background: UIColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1)
    var textPrimary: UIColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
    var textSecondary: UIColor = UIColor(red: 0.749, green: 0.749, blue: 0.749, alpha: 1)
    var border: UIColor = UIColor(red: 0.149, green: 0.149, blue: 0.149, alpha: 1)
    var elementBackground: UIColor = UIColor(red: 0.051, green: 0.051, blue: 0.051, alpha: 1)
    var textTertiary: UIColor = UIColor(red: 0.549, green: 0.549, blue: 0.549, alpha: 1)
    var textDisabled: UIColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
}
