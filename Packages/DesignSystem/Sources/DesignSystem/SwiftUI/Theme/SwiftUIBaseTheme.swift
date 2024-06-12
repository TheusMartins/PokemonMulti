//
//  File.swift
//  
//
//  Created by Scizor on 6/12/24.
//

import SwiftUI

struct SwiftUIBaseTheme: SwiftUIThemable {
    var brandColors: SwiftUIBrandColorsRepresentable
    var textColors: SwiftUITextColorsRepresentable
    var backgroundColors: SwiftUIBackgroundColorsRepresentable
    
    init(mode: ThemeMode = ThemeManager.shared.getTheme()) {
        switch mode {
        case .light:
            brandColors = SwiftUIBrandLightColors()
            textColors = SwiftUITextLightColors()
            backgroundColors = SwiftUIBackgroundLightColors()
        case .dark:
            brandColors = SwiftUIBrandDarkColors()
            textColors = SwiftUITextDarkColors()
            backgroundColors = SwiftUIBackgroundDarkColors()
        }
    }
}
