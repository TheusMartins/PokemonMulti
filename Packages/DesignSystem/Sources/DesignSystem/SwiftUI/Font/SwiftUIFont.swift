//
//  SwiftUIFont.swift
//
//
//  Created by Scizor on 6/12/24.
//

import SwiftUI

extension TextType {
    func swiftUIFont() -> Font {
        let size = fontSize
        let weight: Font.Weight

        switch fontWeight {
        case FontWeight.weightBrandBold:
            weight = .bold
        case FontWeight.weightBrandSemibold:
            weight = .semibold
        case FontWeight.weightNeutralRegular:
            weight = .regular
        default:
            weight = .regular
        }

        return Font.custom(fontWeight, size: size).weight(weight)
    }
}
