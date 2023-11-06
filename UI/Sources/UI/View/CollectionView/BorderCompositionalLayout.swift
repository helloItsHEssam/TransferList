//
//  BorderCompositionalLayout.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/6/23.
//

import UIKit

@objc public protocol BorderCompositionalLayoutDelegate: AnyObject {
    @objc optional func isNeedBorder(at section: Int) -> Bool
    @objc optional func isNeedDivider() -> Bool
    @objc optional func contentInsets(at section: Int,
                                      currentConfig: NSDirectionalEdgeInsets) -> NSDirectionalEdgeInsets
    @objc optional func itemEdgeSpacing() -> NSCollectionLayoutEdgeSpacing?
    @objc optional func createSupplementaryItems(at section: Int) -> [NSCollectionLayoutBoundarySupplementaryItem]?
    @objc optional func createCustomSection(at section: Int) -> NSCollectionLayoutSection?
    @objc optional func customEdgeSeparatorSpacing(currentSpacing: CGFloat) -> NSDirectionalEdgeInsets
}

public class BorderCompositionalLayout: UICollectionViewCompositionalLayout {

    private let borderIdentifier = BorderSectionCollectionView.uiIdentifier
    weak var delegate: BorderCompositionalLayoutDelegate?

    init(delegate: BorderCompositionalLayoutDelegate? = nil) {

        self.delegate = delegate

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44.0))

        let isNeedDivider = delegate?.isNeedDivider?() ?? true

        let defaultSeparatorSpacing = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        let separatorEdgeSpacing = delegate?.customEdgeSeparatorSpacing?(currentSpacing: 16) ?? defaultSeparatorSpacing

        let item = VerticalCollectionLayoutItem(layoutSize: itemSize, isNeedDivider: isNeedDivider,
                                                spacing: separatorEdgeSpacing)
        item.edgeSpacing = delegate?.itemEdgeSpacing?()

        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])

        super.init(sectionProvider: { [weak delegate] sectionIndex, _ -> NSCollectionLayoutSection? in
            var section: NSCollectionLayoutSection! = delegate?.createCustomSection?(at: sectionIndex)
            if section == nil {
                section = NSCollectionLayoutSection(group: group)
            }

            let contentInset = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18)
            let userContentInset = delegate?.contentInsets?(at: sectionIndex,
                                                            currentConfig: contentInset) ?? contentInset

            let isNeedBorder = delegate?.isNeedBorder?(at: sectionIndex) ?? false
            if  isNeedBorder == true {
                let borderDecoration = BorderCompositionalLayout.makeBorderDecoration()
                borderDecoration.contentInsets = userContentInset
                section.decorationItems = [borderDecoration]
            }

            if let supplementaryItems = delegate?.createSupplementaryItems?(at: sectionIndex) {
                section.boundarySupplementaryItems = supplementaryItems
            }

            section.contentInsets = userContentInset
            return section
        })

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 32
        self.configuration = config

        super.register(BorderSectionCollectionView.self, forDecorationViewOfKind: borderIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private static func makeBorderDecoration() -> NSCollectionLayoutDecorationItem {
        let borderItem = NSCollectionLayoutDecorationItem
            .background(elementKind: BorderSectionCollectionView.uiIdentifier)
        return borderItem
    }

}
