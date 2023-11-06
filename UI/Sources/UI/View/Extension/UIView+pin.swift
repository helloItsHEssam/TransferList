//
//  UIView+pin.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

public extension UIView {

    func pinToSuperview() {
        guard let superview = self.superview else {
            fatalError("unable to find superview, you must first add to any view and then call this method")
        }

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }

    func pinToSuperviewWithSafeArea() {
        guard let superview = self.superview else {
            fatalError("unable to find superview, you must first add to any view and then call this method")
        }

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topSafeMargin),
            self.leadingAnchor.constraint(equalTo: superview.leadingSafeMargin),
            self.trailingAnchor.constraint(equalTo: superview.trailingSafeMargin),
            self.bottomAnchor.constraint(equalTo: superview.bottomSafeMargin)
        ])
    }
}

