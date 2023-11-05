//
//  UIView+CornerRadius.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

public extension UIView {

    func setCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
    }

    func convertShapeToCircle() {
        layer.cornerRadius = frame.height / 2
    }
}

