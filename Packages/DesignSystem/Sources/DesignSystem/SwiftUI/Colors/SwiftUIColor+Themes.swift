//
//  SwiftUIColor+Themes.swift
//
//
//  Created by Scizor on 6/12/24.
//

import SwiftUI

public extension Color {
    
    enum BrandColors {
        public static var pikachuYellow: Color {
            getTheme().brandColors.pikachuYellow
        }
        
        public static var pokeballRed: Color {
            getTheme().brandColors.pokeballRed
        }
        
        private static func getTheme() -> SwiftUIBaseTheme {
            return SwiftUIBaseTheme()
        }
    }
    
    enum BackgroundColors {
        public static var backgroundColor: Color {
            getTheme().backgroundColors.backgroundColor
        }
        
        private static func getTheme() -> SwiftUIBaseTheme {
            return SwiftUIBaseTheme()
        }
    }

    enum TextColors {
        public static var background: Color {
            getTheme().textColors.background
        }
        
        public static var textPrimary: Color {
            getTheme().textColors.textPrimary
        }
        
        public static var textSecondary: Color {
            getTheme().textColors.textSecondary
        }
        
        public static var border: Color {
            getTheme().textColors.border
        }
        
        public static var elementBackground: Color {
            getTheme().textColors.elementBackground
        }
        
        public static var textTertiary: Color {
            getTheme().textColors.textTertiary
        }
        
        public static var textDisabled: Color {
            getTheme().textColors.textDisabled
        }
        
        private static func getTheme() -> SwiftUIBaseTheme {
            return SwiftUIBaseTheme()
        }
    }
}
