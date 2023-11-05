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
        case .title3: return 20
        case .body, .headline: return 17
        case .callout: return 16
        case .subheadline: return 15
        case .footnote: return 13
        case .caption2: return 11
        default: return 9
        }
    }
    
    private func ExtraBoldFontSize(basedOnTextStyle textStyle: UIFont.TextStyle) -> CGFloat {
        switch textStyle {
        case .largeTitle: return 34
        case .title1: return 28
        case .subheadline: return 15
        default: return 22
        }
    }
    
    private func regularFontSize(basedOnTextStyle textStyle: UIFont.TextStyle) -> CGFloat {
        switch textStyle {
        case .body, .headline: return 17
        case .callout: return 16
        case .subheadline: return 15
        case .caption2: return 13
        default: return 9
        }
    }
}
