//
//  FavoriteAccountCell.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI

class FavoriteAccountCell: AccountCell {
    
    @InstantiateView(type: UIStackView.self) var stackView
    
    override func setupViews() {
        super.setupViews()

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingSafeMargin),
            stackView.trailingAnchor.constraint(equalTo: trailingSafeMargin),
            stackView.bottomAnchor.constraint(equalTo: bottomSafeMargin),
            stackView.topAnchor.constraint(equalTo: topSafeMargin),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            cardTypeLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        configureStackView()
    }
    
    private func configureStackView() {
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill

        stackView.addArrangedSubview(personImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(cardTypeLabel)
        
        stackView.setCustomSpacing(12, after: personImageView)
        
        configureLabels()
    }
    
    private func configureLabels() {
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 1
        nameLabel.minimumScaleFactor = 0.5
        
        cardTypeLabel.textAlignment = .center
        cardTypeLabel.numberOfLines = 1
        cardTypeLabel.minimumScaleFactor = 0.5
    }
}
