//
//  AssetColor.swift
//  SearchPhoto
//
//  Created by Slava Orlov on 07.03.2023.
//

import UIKit

// MARK: - Constants

enum AssetColor {
    static let clear = UIColor.clear
    static let gray = UIColor(rgb: 0xEEEEEE)
    static let grayText = UIColor(rgb: 0x9C9C9C)
    static let red = UIColor(rgb: 0xEB0C0C)
    static let white = UIColor(rgb: 0xFFFFFF)
    static let grayBorder = UIColor(rgb: 0xEBEBEB)
}

// MARK: - Configure Appearance

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
