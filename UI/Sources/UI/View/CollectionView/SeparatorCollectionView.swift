//
//  SeparatorCollectionView.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

public class SeparatorCollectionView: UICollectionReusableView, UISequenceIdentifier {

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Theme.divider
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        backgroundColor = Theme.divider
    }

    public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        self.frame = layoutAttributes.frame
    }
}
