//
//  AddRemoveFavoriteCell.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import Domain
import UI

class AddRemoveFavoriteCell: BaseCollectionCell {

    @InstantiateView(type: ListLabel.self) var titleLabel

    override func setupViews() {
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingSafeMargin, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topSafeMargin, constant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: trailingSafeMargin, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomSafeMargin, constant: -22)
        ])
        
        configureTitleLabel()
    }
    
    func configureTitleLabel() {
        self.titleLabel.textAlignment = .center
    }
    
    func setFavoriteStatus(isFavorite: Bool) {
        if isFavorite {
            self.titleLabel.textColor = .red
        } else {
            self.titleLabel.textColor = Theme.blue
        }
        titleLabel.text = isFavorite ? "Remove from favorite" : "Save to favorite"
    }
}
