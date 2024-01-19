//
//  CollectionView+Ext.swift
//  ProjectTemplate
//
//  Created by Vikas Kumar on 18/01/24.
//

import UIKit

extension UICollectionView {
    
    func dequeueCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell? {
        dequeueReusableCell(withReuseIdentifier: Cell.className, for: indexPath) as? Cell
    }

    func register(_ nibAndReuse: String) {
        register(UINib(nibName: nibAndReuse, bundle: .main), forCellWithReuseIdentifier: nibAndReuse)
    }

    private func hasItemsInSection(_ indexPath: IndexPath) -> Bool {
        indexPath.section < numberOfSections && indexPath.row < numberOfItems(inSection: indexPath.section)
    }
}

extension UICollectionViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
