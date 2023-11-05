//
//  BaseView.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

public class BaseView: UIView {

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    open func setupViews() {}
}
