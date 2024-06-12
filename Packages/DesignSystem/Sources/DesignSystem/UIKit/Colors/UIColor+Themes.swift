//
//  UIColor+Themes.swift
//
//
//  Created by Scizor on 5/2/24.
//

#if canImport(UIKit)
import UIKit

public extension UIColor {
    
    enum BrandColors {
        public static var pikachuYellow: UIColor {
            getTheme().brandColors.pikachuYellow
        }
        
        public static var pokeballRed: UIColor {
            getTheme().brandColors.pokeballRed
        }
        
        private static func getTheme() -> BaseTheme {
            return BaseTheme()
        }
    }
    
    enum BackgroundColors {
        public static var backgroundColor: UIColor {
            getTheme().backgroundColors.backgroundColor
        }
        
        private static func getTheme() -> BaseTheme {
            return BaseTheme()
        }
    }

    enum TextColors {
        public static var background: UIColor {
            getTheme().textColors.background
        }
        
        public static var textPrimary: UIColor {
            getTheme().textColors.textPrimary
        }
        
        public static var textSecondary: UIColor {
            getTheme().textColors.textSecondary
        }
        
        public static var border: UIColor {
            getTheme().textColors.border
        }
        
        public static var elementBackground: UIColor {
            getTheme().textColors.elementBackground
        }
        
        public static var textTertiary: UIColor {
            getTheme().textColors.textTertiary
        }
        
        public static var textDisabled: UIColor {
            getTheme().textColors.textDisabled
        }
        
        private static func getTheme() -> BaseTheme {
            return BaseTheme()
        }
    }
}
#endif
