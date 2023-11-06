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
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingSafeMargin, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: bottomSafeMargin),
            stackView.topAnchor.constraint(equalTo: topSafeMargin),
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
        cardTypeLabel.textAlignment = .center
    }
}
