//
//  LargeHeaderCell.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI

class LargeHeaderCell: BaseCollectionCell {

    @InstantiateView(type: TitleLabel.self) private var title

    override func setupViews() {
        self.addSubview(title)
        title.pinToSuperview()
    }

    public func setTitle(_ text: String) {
        title.text = text
    }
}
