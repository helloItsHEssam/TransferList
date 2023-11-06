//
//  UICollectionView+RegisterAndDequeue.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

public extension UICollectionView {

    func dequeueReusableCell<T: BaseCollectionCell>(for indexPath: IndexPath) -> T {
        let identifier = T.uiIdentifier
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier,
                                                  for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable CollectionView Cell")
        }
        return cell
    }

    func registerReusableCell<T: BaseCollectionCell>(type: T.Type) {
        let identifier = T.uiIdentifier
        register(T.self, forCellWithReuseIdentifier: identifier)
    }

    func registerSupplementaryView<T: UICollectionReusableView & UISequenceIdentifier>(for kind: String,
                                                                                       type: T.Type) {
        let identifier = T.uiIdentifier
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }

    func dequeueSupplementaryView<T: UICollectionReusableView & UISequenceIdentifier>(for kind: String,
                                                                                      at indexPath: IndexPath) -> T {
        let identifier = T.uiIdentifier
        let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
        guard let supplementaryView = view as? T else {
            fatalError("Unable to Dequeue Reusable Supplementary View")
        }
        return supplementaryView
    }
}
