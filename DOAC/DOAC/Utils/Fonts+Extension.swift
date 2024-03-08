//
//  Fonts+Extension.swift
//  DOAC
//
//  Created by Sanchit Goel on 08/03/24.
//

import UIKit

// Enum for custom fonts
enum CustomFont: String {
    case bold = "Mukta-Bold"
    case extraBold = "Mukta-ExtraBold"
    case extraLight = "Mukta-ExtraLight"
    case light = "Mukta-Light"
    case medium = "Mukta-Medium"
    case regular = "Mukta-Regular"
    case semiBold = "Mukta-SemiBold"
    case reenieBeanie = "ReenieBeanie"
    
    func withSize(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: self.rawValue, size: size) else {
            fatalError("Font \(self.rawValue) not found.")
        }
        return font
    }
}
