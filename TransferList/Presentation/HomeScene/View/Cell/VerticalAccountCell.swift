//
//  VerticalAccountCell.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI
import Domain

class VerticalAccountCell: BaseCollectionCell {

    @InstantiateView(type: ListLabel.self) var nameLabel
    @InstantiateView(type: SubTitleLabel.self) var cardTypeLabel
    @InstantiateView(type: UIStackView.self) var labelsStackView
    @InstantiateView(type: UIImageView.self) var arrowImage
    @InstantiateView(type: UIImageView.self) var favoriteImage
    @InstantiateView(type: UIStackView.self) var imagesStackView

    override func setupViews() {
        super.setupViews()

        addSubview(labelsStackView)
        addSubview(imagesStackView)

        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: topSafeMargin, constant: 16),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomSafeMargin, constant: -16),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingSafeMargin),
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

    func setAccountItem(_ personAccount: PersonBankAccount) {
        nameLabel.text = personAccount.person?.name
        cardTypeLabel.text = personAccount.card?.cardType
    }
}
