//
//  SubTitleLabel.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

public class SubTitleLabel: BaseLabel {

    public override func setupViews() {
        self.font = Raleway.regular.customFont(basedOnTextStyle: .caption2)

        textColor = Theme.secondrayText
    }
}

