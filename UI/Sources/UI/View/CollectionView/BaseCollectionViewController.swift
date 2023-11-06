//
//  BaseCollectionViewController.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

open class BaseCollectionViewController: BaseViewController,
                                         BorderCompositionalLayoutDelegate {

    private(set) lazy var collectionView: BaseCollectionView = {
        BaseCollectionView(frame: .zero, collectionViewLayout: createBorderLayout())
    }()

    open override func setupViews() {
        view.addSubview(collectionView)

        configureCollectionView()
    }

    private func configureCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topSafeMargin),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingSafeMargin),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingSafeMargin),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomSafeMargin)
        ])

        collectionView.contentInset.top = 0
    }

    private func createBorderLayout() -> UICollectionViewCompositionalLayout {
        return BorderCompositionalLayout(delegate: self)
    }

    public func customEdgeSeparatorSpacing(currentSpacing: CGFloat) -> NSDirectionalEdgeInsets {
        return .init(top: 0, leading: self.spaceSeparatorFromEdgeInList,
                     bottom: 0, trailing: self.spaceSeparatorFromEdgeInList)
    }
}
