//
//  VerticalAccountCell.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI
import Domain
import Kingfisher

class VerticalAccountCell: BaseCollectionCell {

    @InstantiateView(type: UIImageView.self) var personImageView
    @InstantiateView(type: ListLabel.self) var nameLabel
    @InstantiateView(type: SubTitleLabel.self) var cardTypeLabel
    @InstantiateView(type: UIStackView.self) var labelsStackView
    @InstantiateView(type: UIImageView.self) var arrowImageView
    @InstantiateView(type: UIImageView.self) var favoriteImageView
    @InstantiateView(type: UIStackView.self) var imagesStackView

    override func prepareForReuse() {
        super.prepareForReuse()
        
        personImageView.image = nil
    }
    
    override func setupViews() {
        super.setupViews()

        addSubview(personImageView)
        addSubview(labelsStackView)
        addSubview(imagesStackView)

        NSLayoutConstraint.activate([
            personImageView.centerYAnchor.constraint(equalTo: centerYSafeMargin),
            personImageView.leadingAnchor.constraint(equalTo: leadingSafeMargin),
            personImageView.heightAnchor.constraint(equalToConstant: 50),
            personImageView.widthAnchor.constraint(equalToConstant: 50),
            labelsStackView.topAnchor.constraint(equalTo: topSafeMargin, constant: 16),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomSafeMargin, constant: -16),
            labelsStackView.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 12),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingSafeMargin)
//            labelsStackView.trailingAnchor.constraint(lessThanOrEqualTo: clock.leadingAnchor, constant: -12),
//            clock.centerYAnchor.constraint(equalTo: centerYSafeMargin),
//            clock.trailingAnchor.constraint(equalTo: trailingSafeMargin, constant: -18)
        ])

        configurePersonImageView()
        configureLabelsStackView()
    }

    private func configurePersonImageView() {
        personImageView.contentMode = .scaleAspectFit
        personImageView.layer.borderColor = Theme.border?.cgColor
        personImageView.layer.borderWidth = 0.5
        personImageView.setCornerRadius(radius: 25)
        personImageView.layer.masksToBounds = true
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
        cardTypeLabel.text = personAccount.card?.cardNumber
        
        let avatarUrl = URL(string: personAccount.person?.avatar ?? "")
        personImageView.kf.setImage(with: avatarUrl, placeholder: UIImage())
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        personImageView.layer.borderColor = Theme.border?.cgColor
    }
}
