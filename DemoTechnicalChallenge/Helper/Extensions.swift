//
//  Extensions.swift
//  DemoTechnicalChallenge
//
//  Created by NeoSOFT on 04/11/24.
//

import UIKit

// MARK: - UIColor Extensions for Custom Colors
extension UIColor {
    static var customTextColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
        }
    }
    
    static var customDescriptionTextColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.lightGray : UIColor.darkGray
        }
    }

    static var customSeparatorColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(white: 0.2, alpha: 1) : UIColor(white: 0.9, alpha: 1)
        }
    }
}
