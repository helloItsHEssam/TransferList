//
//  BorderSectionCollectionView.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

public class BorderSectionCollectionView: UICollectionReusableView, UISequenceIdentifier {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
    }

    private func setupView() {
        backgroundColor = Theme.supplementaryBackground
        layer.borderWidth = 1.0
        setCornerRadius(radius: 18.0)
        layer.borderColor = Theme.border?.cgColor
    }
}
