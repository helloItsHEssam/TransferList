//
//  VerticalAccountCell.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI
import Domain

class VerticalAccountCell: AccountCell {

    @InstantiateView(type: UIStackView.self) var labelsStackView
    @InstantiateView(type: UIImageView.self) var arrowImageView
    @InstantiateView(type: UIImageView.self) var favoriteImageView
    @InstantiateView(type: UIStackView.self) var imagesStackView
    
    override func setupViews() {
        super.setupViews()

        addSubview(personImageView)
        addSubview(labelsStackView)
        addSubview(imagesStackView)

        NSLayoutConstraint.activate([
            personImageView.centerYAnchor.constraint(equalTo: centerYSafeMargin),
            personImageView.leadingAnchor.constraint(equalTo: leadingSafeMargin),
            labelsStackView.topAnchor.constraint(equalTo: topSafeMargin, constant: 16),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomSafeMargin, constant: -16),
            labelsStackView.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 12),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingSafeMargin)
//            labelsStackView.trailingAnchor.constraint(lessThanOrEqualTo: clock.leadingAnchor, constant: -12),
//            clock.centerYAnchor.constraint(equalTo: centerYSafeMargin),
//            clock.trailingAnchor.constraint(equalTo: trailingSafeMargin, constant: -18)
        ])

        configureLabelsStackView()
    }

    private func configureLabelsStackView() {
        labelsStackView.spacing = 4
        labelsStackView.alignment = .leading
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fill

        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(cardTypeLabel)
    }

    override func setAccountItem(_ personAccount: PersonBankAccount) {
        super.setAccountItem(personAccount)
        
        // set isFavorite
    }
}
