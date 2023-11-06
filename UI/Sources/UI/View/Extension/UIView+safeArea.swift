//
//  UIView+safeArea.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

public extension UIView {

    var topSafeMargin: NSLayoutYAxisAnchor {
        self.safeAreaLayoutGuide.topAnchor
    }

    var bottomSafeMargin: NSLayoutYAxisAnchor {
        self.safeAreaLayoutGuide.bottomAnchor
    }

    var leadingSafeMargin: NSLayoutXAxisAnchor {
        self.safeAreaLayoutGuide.leadingAnchor
    }

    var trailingSafeMargin: NSLayoutXAxisAnchor {
        self.safeAreaLayoutGuide.trailingAnchor
    }

    var widthSafeMargin: NSLayoutDimension {
        self.safeAreaLayoutGuide.widthAnchor
    }

    var heightSafeMargin: NSLayoutDimension {
        self.safeAreaLayoutGuide.heightAnchor
    }

    var centerXSafeMargin: NSLayoutXAxisAnchor {
        self.safeAreaLayoutGuide.centerXAnchor
    }

    var centerYSafeMargin: NSLayoutYAxisAnchor {
        self.safeAreaLayoutGuide.centerYAnchor
    }
}
