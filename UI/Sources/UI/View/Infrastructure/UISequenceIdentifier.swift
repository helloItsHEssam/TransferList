//
//  UISequenceIdentifier.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import Foundation
import UIKit

public protocol UISequenceIdentifier {}

public extension UISequenceIdentifier where Self: UICollectionViewCell {

    static var uiIdentifier: String {
        String(describing: Self.self)
    }
}

public extension UISequenceIdentifier where Self: UICollectionReusableView {

    static var uiIdentifier: String {
        String(describing: Self.self)
    }
}
