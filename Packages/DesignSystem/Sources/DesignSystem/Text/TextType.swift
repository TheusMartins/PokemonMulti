//
//  TextType.swift
//
//
//  Created by Scizor on 5/2/24.
//

import UIKit

public enum TextType {
    /// display01
    /// - Size:  xxxl (64)
    /// - font:  Brand Bold
    /// - line Height:  rule 03 (76)
    case display01

    /// display02
    /// - Size:  xxl (48)
    /// - font:  Brand Bold
    /// - line Height:  rule 01 (52)
    case display02

    /// heading01
    /// - Size:  xl (40)
    /// - font:  Brand Bold
    /// - line Height: rule 04 (54)
    case heading01

    /// heading02
    /// - Size:  lg (32)
    /// - font:  Brand Bold
    /// - line Height:  rule 04 (48)
    case heading02

    /// heading03
    /// - Size:  md (24)
    /// - font:  Brand Bold
    /// - line Height:  rule 03 (36)
    case heading03

    /// heading04
    /// - Size:  sm (20)
    /// - font:  Brand Bold
    /// - line Height:  rule 03 (32)
    case heading04

    /// heading05
    /// - Size:  xs (18)
    /// - font:  Brand Semibold
    /// - line Height:  rule 02 (26)
    case heading05

    /// heading06
    /// - Size:  xxs (14)
    /// - font:  Brand Semibold
    /// - line Height:  rule 02 (22)
    case heading06

    /// body
    /// - Size:  xs (18)
    /// - font:  Open-Sans Regular
    /// - line Height:  rule 04 (32)
    case body

    /// subtitleMedium
    /// - Size: xxs (14)
    /// - font:  Open-Sans Regular
    /// - line Height:  rule 02 (22)
    case subtitleMedium

    /// subtitleSmall
    /// - Size:  xxxs (12)
    /// - font:  Open-Sans Regular
    /// - line Height:  rule 02 (20)
    case subtitleSmall

    /// overlineMedium
    /// - Size:  xs (18)
    /// - font:  Open-Sans Regular
    /// - line Height:  rule 01 (22)
    case overlineMedium

    /// overlineSmall
    /// - Size:  xxxs (12)
    /// - font:  Open-Sans Regular
    /// - line Height:  rule 01 (16)
    case overlineSmall

    /// button
    /// - Size:  xs (18)
    /// - font:  Open-Sans Regular
    /// - line Height:  rule 01 (22)
    case button

    /// linkMedium
    /// - Size:  xs (18)
    /// - font:  Open-Sans Regular
    /// - line Height:  rule 04 (32)
    case linkMedium

    /// linkSmall
    /// - Size:  xxs (14)
    /// - font:  Open-Sans Regular
    /// - line Height:  rule 04 (28)
    case linkSmall

    /// labelStatic
    /// - Size:  xs (18)
    /// - font:  Open-Sans Regular
    /// - line Height:  rule 01 (22)
    case labelStatic

    /// labelActive
    /// - Size:  xxxs (12)
    /// - font:  Open-Sans Regular
    /// - line Height:  rule 01 (16)
    case labelActive

    /// input
    /// - Size:  xs (18)
    /// - font:  Open-Sans Regular
    /// - line Height:  rule 01 (22)
    case input

    /// helperText
    /// - Size:  xxs (12)
    /// - font:  Open-Sans Regular
    /// - line Height:  rule 01 (16)
    case helperText
}

extension TextType {
    var fontSize: CGFloat {
        switch self {
        case .display01: return CGFloat(FontSize.sizeFontXxxl)
        case .display02: return CGFloat(FontSize.sizeFontXxl)
        case .heading01: return CGFloat(FontSize.sizeFontXl)
        case .heading02: return CGFloat(FontSize.sizeFontLg)
        case .heading03: return CGFloat(FontSize.sizeFontMd)
        case .heading04: return CGFloat(FontSize.sizeFontSm)
        case .heading05: return CGFloat(FontSize.sizeFontXs)
        case .heading06: return CGFloat(FontSize.sizeFontXxs)
        case .body: return CGFloat(FontSize.sizeFontXs)
        case .subtitleMedium: return CGFloat(FontSize.sizeFontXxs)
        case .subtitleSmall: return CGFloat(FontSize.sizeFontXxxs)
        case .overlineMedium: return CGFloat(FontSize.sizeFontXs)
        case .overlineSmall: return CGFloat(FontSize.sizeFontXxxs)
        case .button: return CGFloat(FontSize.sizeFontXs)
        case .linkMedium: return CGFloat(FontSize.sizeFontXs)
        case .linkSmall: return CGFloat(FontSize.sizeFontXxs)
        case .labelStatic: return CGFloat(FontSize.sizeFontXs)
        case .labelActive: return CGFloat(FontSize.sizeFontXxxs)
        case .input: return CGFloat(FontSize.sizeFontXs)
        case .helperText: return CGFloat(FontSize.sizeFontXxxs)
        }
    }

    var fontWeight: String {
        switch self {
        case .display01: return FontWeight.weightBrandBold
        case .display02: return FontWeight.weightBrandBold
        case .heading01: return FontWeight.weightBrandBold
        case .heading02: return FontWeight.weightBrandBold
        case .heading03: return FontWeight.weightBrandBold
        case .heading04: return FontWeight.weightBrandBold
        case .heading05: return FontWeight.weightBrandSemibold
        case .heading06: return FontWeight.weightBrandSemibold
        case .body: return FontWeight.weightNeutralRegular
        case .subtitleMedium: return FontWeight.weightNeutralRegular
        case .subtitleSmall: return FontWeight.weightNeutralRegular
        case .overlineMedium: return FontWeight.weightNeutralRegular
        case .overlineSmall: return FontWeight.weightNeutralRegular
        case .button: return FontWeight.weightNeutralRegular
        case .linkMedium: return FontWeight.weightNeutralRegular
        case .linkSmall: return FontWeight.weightNeutralRegular
        case .labelStatic: return FontWeight.weightNeutralRegular
        case .labelActive: return FontWeight.weightNeutralRegular
        case .input: return FontWeight.weightNeutralRegular
        case .helperText: return FontWeight.weightNeutralRegular
        }
    }

    var lineHeight: CGFloat {
        switch self {
        case .display01: return CGFloat(LineHeight.sizeLineHeightXxxl03)
        case .display02: return CGFloat(LineHeight.sizeLineHeightXxxl01)
        case .heading01: return CGFloat(LineHeight.sizeLineHeightXl04)
        case .heading02: return CGFloat(LineHeight.sizeLineHeightLg04)
        case .heading03: return CGFloat(LineHeight.sizeLineHeightMd03)
        case .heading04: return CGFloat(LineHeight.sizeLineHeightSm03)
        case .heading05: return CGFloat(LineHeight.sizeLineHeightXs02)
        case .heading06: return CGFloat(LineHeight.sizeLineHeightXxs02)
        case .body: return CGFloat(LineHeight.sizeLineHeightXs04)
        case .subtitleMedium: return CGFloat(LineHeight.sizeLineHeightXxs02)
        case .subtitleSmall: return CGFloat(LineHeight.sizeLineHeightXxxs02)
        case .overlineMedium: return CGFloat(LineHeight.sizeLineHeightXs01)
        case .overlineSmall: return CGFloat(LineHeight.sizeLineHeightXxxs01)
        case .button: return CGFloat(LineHeight.sizeLineHeightXxxs01)
        case .linkMedium: return CGFloat(LineHeight.sizeLineHeightXs04)
        case .linkSmall: return CGFloat(LineHeight.sizeLineHeightXxxs04)
        case .labelStatic: return CGFloat(LineHeight.sizeLineHeightXs01)
        case .labelActive: return CGFloat(LineHeight.sizeLineHeightXxxs01)
        case .input: return CGFloat(LineHeight.sizeLineHeightXs01)
        case .helperText: return CGFloat(LineHeight.sizeLineHeightXxxs01)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .display01: return .TextColors.textPrimary
        case .display02: return .TextColors.textPrimary
        case .heading01: return .TextColors.textPrimary
        case .heading02: return .TextColors.textPrimary
        case .heading03: return .TextColors.textSecondary
        case .heading04: return .TextColors.textSecondary
        case .heading05: return .TextColors.textSecondary
        case .heading06: return .TextColors.textTertiary
        case .body: return .TextColors.textPrimary
        case .subtitleMedium: return .TextColors.textSecondary
        case .subtitleSmall: return .TextColors.textTertiary
        case .overlineMedium: return .TextColors.textSecondary
        case .overlineSmall: return .TextColors.textTertiary
        case .button: return .TextColors.textPrimary
        case .linkMedium: return .TextColors.textPrimary
        case .linkSmall: return .TextColors.textSecondary
        case .labelStatic: return .TextColors.textSecondary
        case .labelActive: return .TextColors.textPrimary
        case .input: return .TextColors.textPrimary
        case .helperText: return .TextColors.textDisabled
        }
    }

    var attributeds: [NSAttributedString.Key : Any]? {
        switch self {
        case .linkSmall:
            return [
                .underlineStyle : NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.clear,
                .font: TextType.linkSmall.font()
            ]
        case .linkMedium:
            return [
                .underlineStyle : NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.clear,
                .font: TextType.linkMedium.font()
            ]
        default:
            return nil
        }
    }

    var formatter: ((String?) -> String?) {
        switch self {
        case .overlineSmall,
             .overlineMedium:
            return { value -> String? in return value?.uppercased() }
        default:
            return { value -> String? in return value }
        }
    }

    func font() -> UIFont {
        return UIFont.fontType(self)
    }
}

extension UIFont {
    static func fontType(_ type: TextType) -> UIFont {
        return UIFont(name: type.fontWeight, size: type.fontSize) ?? UIFont.systemFont(ofSize: type.fontSize)
    }

    static func fontType(_ fontWeight: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: fontWeight, size: CGFloat(size)) else {
            fatalError("\(fontWeight) not found")
        }
        return font
    }
}
