//
//  SwiftUIColors.swift
//  
//
//  Created by Scizor on 6/12/24.
//

import SwiftUI

struct SwiftUIBrandLightColors: SwiftUIBrandColorsRepresentable {
    var pikachuYellow: Color = Color(red: 0.992, green: 0.796, blue: 0.192)
    var pokeballRed: Color = Color(red: 0.929, green: 0.106, blue: 0.141)
}

struct SwiftUIBackgroundLightColors: SwiftUIBackgroundColorsRepresentable {
    var backgroundColor: Color = Color(red: 0.980, green: 0.980, blue: 0.988)
}

struct SwiftUITextLightColors: SwiftUITextColorsRepresentable {
    var background: Color = Color(red: 1.000, green: 1.000, blue: 1.000)
    var textPrimary: Color = Color(red: 0.251, green: 0.251, blue: 0.251)
    var textSecondary: Color = Color(red: 0.051, green: 0.051, blue: 0.051)
    var border: Color = Color(red: 0.851, green: 0.851, blue: 0.851)
    var elementBackground: Color = Color(red: 0.949, green: 0.949, blue: 0.949)
    var textTertiary: Color = Color(red: 0.451, green: 0.451, blue: 0.451)
    var textDisabled: Color = Color(red: 0.667, green: 0.667, blue: 0.667)
}

struct SwiftUIBrandDarkColors: SwiftUIBrandColorsRepresentable {
    var pikachuYellow: Color = Color(red: 0.992, green: 0.796, blue: 0.192)
    var pokeballRed: Color = Color(red: 0.929, green: 0.106, blue: 0.141)
}

import SwiftUI

struct SwiftUIBackgroundDarkColors: SwiftUIBackgroundColorsRepresentable {
    var backgroundColor: Color = Color(red: 0.098, green: 0.118, blue: 0.137)
}

import SwiftUI

struct SwiftUITextDarkColors: SwiftUITextColorsRepresentable {
    var background: Color = Color(red: 0.000, green: 0.000, blue: 0.000)
    var textPrimary: Color = Color(red: 0.949, green: 0.949, blue: 0.949)
    var textSecondary: Color = Color(red: 0.749, green: 0.749, blue: 0.749)
    var border: Color = Color(red: 0.149, green: 0.149, blue: 0.149)
    var elementBackground: Color = Color(red: 0.051, green: 0.051, blue: 0.051)
    var textTertiary: Color = Color(red: 0.549, green: 0.549, blue: 0.549)
    var textDisabled: Color = Color(red: 0.333, green: 0.333, blue: 0.333)
}
