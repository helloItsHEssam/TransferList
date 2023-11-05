//
//  ListLabel.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

public class ListLabel: BaseLabel {

    public override func setupViews() {
        self.font = Raleway.regular.customFont(basedOnTextStyle: .subheadline)
    }
}
