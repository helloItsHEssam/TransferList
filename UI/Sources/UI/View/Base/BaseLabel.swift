//
//  BaseLabel.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

open class BaseLabel: UILabel {

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        customize()
        setupViews()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        customize()
        setupViews()
    }

    private func customize() {

        adjustsFontForContentSizeCategory = true
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.textAlignment = .left
        self.textColor = Theme.primaryText
    }

    open func setupViews() {}
}
