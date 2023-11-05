//
//  Raleway.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/5/23.
//

import Foundation
import UIKit

public enum Raleway: CaseIterable, CustomStringConvertible {
    
    case regular
    case semiBold
    case extraBold
    
    public var fileExtension: String {
        return "ttf"
    }
    
    public var description: String {
        var weight: String
        switch self {
        case .regular: weight = "Regular"
        case .semiBold: weight = "SemiBold"
        case .extraBold: weight = "ExtraBold"
        }
        
        return "Raleway-" + weight
    }

    public func customFont(basedOnTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        let name = String(describing: self)
        let size = fontSize(basedOnTextStyle: textStyle)

        guard let font = UIFont(name: name, size: size) else {
            return UIFont.preferredFont(forTextStyle: textStyle)
        }

        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        return fontMetrics.scaledFont(for: font)
    }
    
    func fontSize(basedOnTextStyle textStyle: UIFont.TextStyle) -> CGFloat {
        switch self {
        case .extraBold: return ExtraBoldFontSize(basedOnTextStyle: textStyle)
        case .semiBold: return semiBoldFontSize(basedOnTextStyle: textStyle)
        case .regular: return regularFontSize(basedOnTextStyle: textStyle)
        }
    }
}

fileprivate extension Raleway {

    private func semiBoldFontSize(basedOnTextStyle textStyle: UIFont.TextStyle) -> CGFloat {
        switch textStyle {
        case .headline: return 22
        case .subheadline: return 18
        default: return 14
        }
    }
    
    private func ExtraBoldFontSize(basedOnTextStyle textStyle: UIFont.TextStyle) -> CGFloat {
        switch textStyle {
        case .headline: return 24
        case .subheadline: return 20
        default: return 16
        }
    }
    
    private func regularFontSize(basedOnTextStyle textStyle: UIFont.TextStyle) -> CGFloat {
        switch textStyle {
        case .title2: return 16
        case .title3: return 12
        default: return 10
        }
    }
}
