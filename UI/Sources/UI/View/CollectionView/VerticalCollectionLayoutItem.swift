//
//  VerticalCollectionLayoutItem.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

public class VerticalCollectionLayoutItem: NSCollectionLayoutItem {

    private static func makeSeparatorSupplementaryItem(spacing: NSDirectionalEdgeInsets)
                                                    -> NSCollectionLayoutSupplementaryItem {
        let anchor = NSCollectionLayoutAnchor(edges: [.top, .leading], absoluteOffset: .zero)
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .absolute(0.5))
        let seprator = NSCollectionLayoutSupplementaryItem(layoutSize: size,
                                                        elementKind: SeparatorCollectionView.uiIdentifier,
                                                        containerAnchor: anchor)
        seprator.contentInsets = spacing
        return seprator
    }

    convenience init(layoutSize: NSCollectionLayoutSize, isNeedDivider: Bool,
                     spacing: NSDirectionalEdgeInsets) {
        var supplementrayItems: [NSCollectionLayoutSupplementaryItem] = []
        if isNeedDivider {
            supplementrayItems.append(
                VerticalCollectionLayoutItem.makeSeparatorSupplementaryItem(spacing: spacing)
            )
        }

        self.init(layoutSize: layoutSize, supplementaryItems: supplementrayItems)
    }
}
