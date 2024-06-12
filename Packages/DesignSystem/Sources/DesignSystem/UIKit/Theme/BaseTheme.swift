//
//  BaseTheme.swift
//
//
//  Created by Scizor on 5/2/24.
//
#if canImport(UIKit)
import UIKit

struct BaseTheme: Themable {
    var brandColors: BrandColorsRepresentable
    var textColors: TextColorsRepresentable
    var backgroundColors: BackgroundColorsRepresentable
    
    init(mode: ThemeMode = ThemeManager.shared.getTheme()) {
        switch mode {
        case .light:
            brandColors = BrandLightColors()
            textColors = TextLightColors()
            backgroundColors = BackgroundLightColors()
        case .dark:
            brandColors = BrandDarkColors()
            textColors = TextDarkColors()
            backgroundColors = BackgroundDarkColors()
        }
    }
}
#endif
