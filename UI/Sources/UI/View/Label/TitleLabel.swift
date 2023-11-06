//
//  TitleLabel.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

public class TitleLabel: BaseLabel {

    public override func setupViews() {
        self.font = Raleway.extraBold.customFont(basedOnTextStyle: .largeTitle)
    }
}

