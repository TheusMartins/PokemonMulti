//
//  UIColor+Themes.swift
//
//
//  Created by Scizor on 5/2/24.
//

import UIKit

extension UIColor: BrandColorsRepresentable {
    public var pikachuYellow: UIColor {
        getTheme().brandColors.pikachuYellow
    }
    
    public var pokeballRed: UIColor {
        getTheme().brandColors.pokeballRed
    }
}

extension UIColor: BackgroundColorsRepresentable {
    public var backgroundColor: UIColor {
        getTheme().backgroundColors.backgroundColor
    }
}

extension UIColor: TextColorsRepresentable {
    public var background: UIColor {
        getTheme().textColors.background
    }
    
    public var textPrimary: UIColor {
        getTheme().textColors.textPrimary
    }
    
    public var textSecondary: UIColor {
        getTheme().textColors.textSecondary
    }
    
    public var border: UIColor {
        getTheme().textColors.border
    }
    
    public var elementBackground: UIColor {
        getTheme().textColors.elementBackground
    }
    
    public var textTertiary: UIColor {
        getTheme().textColors.textTertiary
    }
    
    public var textDisabled: UIColor {
        getTheme().textColors.textDisabled
    }
}

extension UIColor {
    private func getTheme() -> BaseTheme {
        return BaseTheme()
    }
}
