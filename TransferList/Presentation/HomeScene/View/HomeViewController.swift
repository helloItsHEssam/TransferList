//
//  HomeViewController.swift
//  TransferList
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit
import UI

class HomeViewController: BaseCollectionViewController {

    private var dataSource: HomeCollectionViewDataSource!

    override func setupViews() {
        super.setupViews()
                
        configureDataSource()
        dataSource.LoadTitle(message: "Favorites")
    }
    
    private func configureDataSource() {
        dataSource = .init(collectionView: collectionView)
    }
}
