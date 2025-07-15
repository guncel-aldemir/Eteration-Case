//
//  UIColor+Ext.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 12.07.2025.
//

import UIKit


extension UIColor {
    
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

                if hexSanitized.hasPrefix("#") {
                    hexSanitized.remove(at: hexSanitized.startIndex)
                }

                var rgb: UInt64 = 0
                Scanner(string: hexSanitized).scanHexInt64(&rgb)

                let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
                let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
                let b = CGFloat(rgb & 0x0000FF) / 255.0

                self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    static func blend(color1: UIColor, color2: UIColor, ratio: CGFloat) -> UIColor {
            let ratio = min(max(ratio, 0), 1)
            var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
            var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
            
            color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
            color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
            
            return UIColor(
                red: r1 * (1 - ratio) + r2 * ratio,
                green: g1 * (1 - ratio) + g2 * ratio,
                blue: b1 * (1 - ratio) + b2 * ratio,
                alpha: a1 * (1 - ratio) + a2 * ratio
            )
        }
}
