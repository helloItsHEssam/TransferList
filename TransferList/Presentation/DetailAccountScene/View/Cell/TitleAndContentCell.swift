//
//  TitleAndContentCell.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI

class TitleAndContentCell: BaseCollectionCell {

    @InstantiateView(type: ListLabel.self) var titleLabel
    @InstantiateView(type: SubTitleLabel.self) var valueLabel

    override func setupViews() {
        addSubview(titleLabel)
        addSubview(valueLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingSafeMargin, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topSafeMargin, constant: 22),
            titleLabel.bottomAnchor.constraint(equalTo: bottomSafeMargin, constant: -22),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: widthSafeMargin, multiplier: 0.55),
            valueLabel.trailingAnchor.constraint(equalTo: trailingSafeMargin, constant: -16),
            valueLabel.topAnchor.constraint(equalTo: topSafeMargin, constant: 22),
            valueLabel.bottomAnchor.constraint(equalTo: bottomSafeMargin, constant: -22),
            valueLabel.widthAnchor.constraint(lessThanOrEqualTo: widthSafeMargin, multiplier: 0.4)
        ])

        configureContentLabel()
    }

    private func configureContentLabel() {
        valueLabel.textAlignment = .right
    }

    func set(title: String, value: Int) {
        self.titleLabel.text = title
        self.valueLabel.text = "\(value)"
    }
}
