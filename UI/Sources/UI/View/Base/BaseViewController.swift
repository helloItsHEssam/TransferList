//
//  BaseViewController.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

public class BaseViewController: UIViewController {

    var spaceSeparatorFromEdgeInList: CGFloat {
        return 16
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Theme.background

        setupViews()
    }

    open func setupViews() {}

    public override func viewWillTransition(to size: CGSize,
                                            with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        guard let collectionView = view.viewWithTag(1009) as? BaseCollectionView else { return }
        let indexPaths = collectionView.indexPathsForVisibleItems
        guard indexPaths.isEmpty == false else { return }
        let middleIndex = indexPaths.count / 2
        let middleIndexPathVisible = indexPaths.sorted()[middleIndex]

        coordinator.animate(alongsideTransition: { _ in
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.scrollToItem(at: middleIndexPathVisible,
                                        at: .top, animated: false)
        }, completion: nil)
    }
}

