//
//  FontManager.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 13.07.2025.
//

import UIKit


enum FontStyle {
    case regular
    case medium
    case bold
    case semiBold
    case extraBold
    var fontName: String {
        switch self {
        case .regular: return "Montserrat-Regular"
        case .medium: return "Montserrat-Medium"
        case .semiBold: return "Montserrat-SemiBold"
        case .bold: return "Montserrat-Bold"
        case .extraBold: return "Montserrat-ExtraBold"
        }
    }
}

enum FontSize: CGFloat {
    case body1 = 16.0
    case body2 = 14.0
    case body3 = 12.0
    case body4 = 10.0
    case heading1 = 24.0
    case heading2 = 20.0
    case heading3 = 18.0
}

struct FontManager {
    static func customFont(size: FontSize, style: FontStyle) -> UIFont {
        
        if let font = UIFont(name: style.fontName, size: size.rawValue) {
            return font
        } else {
            return UIFont.systemFont(ofSize: size.rawValue, weight: .regular)
        }
    }
    struct Body1 {
        static let regular = FontManager.customFont(size: .body1, style: .regular)
        static let medium = FontManager.customFont(size: .body1, style: .medium)
        static let semibold = FontManager.customFont(size: .body1, style: .semiBold)
        static let bold = FontManager.customFont(size: .body1, style: .bold)
        static let extraBold = FontManager.customFont(size: .body1, style: .extraBold)
    }
    
    struct Body2 {
        static let regular = FontManager.customFont(size: .body2, style: .regular)
        static let medium = FontManager.customFont(size: .body2, style: .medium)
        static let semibold = FontManager.customFont(size: .body2, style: .semiBold)
        static let bold = FontManager.customFont(size: .body2, style: .bold)
        static let extraBold = FontManager.customFont(size: .body2, style: .extraBold)
    }
    
    struct Body3 {
        static let regular = FontManager.customFont(size: .body3, style: .regular)
        static let medium = FontManager.customFont(size: .body3, style: .medium)
        static let semibold = FontManager.customFont(size: .body3, style: .semiBold)
        static let bold = FontManager.customFont(size: .body3, style: .bold)
        static let extraBold = FontManager.customFont(size: .body3, style: .extraBold)
    }
    
    
    struct Body4 {
        static let regular = FontManager.customFont(size: .body4, style: .regular)
        static let medium = FontManager.customFont(size: .body4, style: .medium)
        static let semibold = FontManager.customFont(size: .body4, style: .semiBold)
        static let bold = FontManager.customFont(size: .body4, style: .bold)
        static let extraBold = FontManager.customFont(size: .body4, style: .extraBold)
    }
    
    struct Heading1 {
        static let regular = FontManager.customFont(size: .heading1, style: .regular)
        static let medium = FontManager.customFont(size: .heading1, style: .medium)
        static let semibold = FontManager.customFont(size: .heading1, style: .semiBold)
        static let bold = FontManager.customFont(size: .heading1, style: .bold)
        static let extraBold = FontManager.customFont(size: .heading1, style: .extraBold)
    }
    
    struct Heading2 {
        static let regular = FontManager.customFont(size: .heading2, style: .regular)
        static let medium = FontManager.customFont(size: .heading2, style: .medium)
        static let semibold = FontManager.customFont(size: .heading2, style: .semiBold)
        static let bold = FontManager.customFont(size: .heading2, style: .bold)
        static let extraBold = FontManager.customFont(size: .heading2, style: .extraBold)
    }
    
    struct Heading3 {
        static let regular = FontManager.customFont(size: .heading3, style: .regular)
        static let medium = FontManager.customFont(size: .heading3, style: .medium)
        static let semibold = FontManager.customFont(size: .heading3, style: .semiBold)
        static let bold = FontManager.customFont(size: .heading3, style: .bold)
        static let extraBold = FontManager.customFont(size: .heading3, style: .extraBold)
    }
}
