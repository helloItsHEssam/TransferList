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
            labelsStackView.trailingAnchor
                .constraint(lessThanOrEqualTo: imagesStackView.leadingAnchor,
                            constant: -12),
            imagesStackView.trailingAnchor.constraint(equalTo: trailingSafeMargin),
            imagesStackView.centerYAnchor.constraint(equalTo: centerYSafeMargin),
            imagesStackView.trailingAnchor.constraint(equalTo: trailingSafeMargin),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 15),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 15),
            arrowImageView.widthAnchor.constraint(equalToConstant: 15),
            arrowImageView.heightAnchor.constraint(equalToConstant: 15)
        ])

        configureLabelsStackView()
        configureImageStackView()
    }

    private func configureLabelsStackView() {
        labelsStackView.spacing = 4
        labelsStackView.alignment = .leading
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fill

        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(cardTypeLabel)
    }
    
    private func configureImageStackView() {
        imagesStackView.spacing = 12
        imagesStackView.alignment = .center
        imagesStackView.axis = .horizontal
        imagesStackView.distribution = .fill

        imagesStackView.addArrangedSubview(favoriteImageView)
        imagesStackView.addArrangedSubview(arrowImageView)
        
        configureImages()
    }
    
    private func configureImages() {
        favoriteImageView.image = UIImage(named: "star")
        
        arrowImageView.image = UIImage(named: "arrow")
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.transform = CGAffineTransform(rotationAngle: -(.pi / 2))
    }

    override func setAccountItem(_ personAccount: PersonBankAccount) {
        super.setAccountItem(personAccount)
        
        favoriteImageView.isHidden = !personAccount.isFavorite
    }
}
