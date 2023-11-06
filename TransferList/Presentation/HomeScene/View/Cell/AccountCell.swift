//
//  AccountCell.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI
import Domain
import Kingfisher

class AccountCell: BaseCollectionCell {

    @InstantiateView(type: UIImageView.self) var personImageView
    @InstantiateView(type: ListLabel.self) var nameLabel
    @InstantiateView(type: SubTitleLabel.self) var cardTypeLabel

    override func prepareForReuse() {
        super.prepareForReuse()
        
        personImageView.image = nil
    }
    
    override func setupViews() {
        super.setupViews()

        NSLayoutConstraint.activate([
            personImageView.heightAnchor.constraint(equalToConstant: 50),
            personImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        configurePersonImageView()
    }
    
    private func configurePersonImageView() {
        personImageView.contentMode = .scaleAspectFit
        personImageView.layer.borderColor = Theme.border?.cgColor
        personImageView.layer.borderWidth = 0.5
        personImageView.setCornerRadius(radius: 25)
        personImageView.layer.masksToBounds = true
    }

    open func setAccountItem(_ personAccount: PersonBankAccount) {
        nameLabel.text = personAccount.person?.name
        cardTypeLabel.text = personAccount.card?.cardType
        
        let avatarUrl = URL(string: personAccount.person?.avatar ?? "")
        personImageView.kf.setImage(with: avatarUrl, placeholder: UIImage(named: "imageFailed"))
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        personImageView.layer.borderColor = Theme.border?.cgColor
    }
}
