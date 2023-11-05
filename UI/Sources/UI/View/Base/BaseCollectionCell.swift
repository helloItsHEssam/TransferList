//
//  BaseCollectionCell.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

public class BaseCollectionCell: UICollectionViewCell, UISequenceIdentifier {

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
    }

    open func setupViews() {}
}
