//
//  HomeViewController.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI

class HomeViewController: BaseCollectionViewController {

    @InstantiateView(type: TitleLabel.self) private var titleLabel

    override func setupViews() {
        
        titleLabel.text = "Hello Blu!"
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXSafeMargin),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYSafeMargin),
        ])
    }
}
