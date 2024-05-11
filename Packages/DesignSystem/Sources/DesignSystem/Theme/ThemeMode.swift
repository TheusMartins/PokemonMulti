//
//  ThemeMode.swift
//
//
//  Created by Scizor on 5/2/24.
//

#if canImport(UIKit)
import UIKit

enum ThemeMode {
    case light
    case dark
}

final class ThemeManager {
    // Singleton instance for global access
    static let shared = ThemeManager()
    
    private init() {} // Private initialization to ensure singleton usage
    
    func getTheme() -> ThemeMode {
        return UIScreen.main.traitCollection.userInterfaceStyle == .light ? .light : .dark
    }
}
#endif
