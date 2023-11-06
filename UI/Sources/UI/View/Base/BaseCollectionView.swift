//
//  BaseCollectionView.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

open class BaseCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Theme.blue
        alwaysBounceVertical = true
        tag = 1009 // for getting collectionView inside BaseViewController
        keyboardDismissMode = .interactiveWithAccessory

        contentInset = .init(top: 32, left: 0, bottom: 20, right: 0)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        guard previousTraitCollection?.userInterfaceStyle == traitCollection.userInterfaceStyle else { return }
        collectionViewLayout.invalidateLayout()
    }
}
