//
//  TableView+Ext.swift
//  ProjectTemplate
//
//  Created by Vikas Kumar on 18/01/24.
//

import UIKit

extension UITableView {
    
    func dequeueCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell? {
        dequeueReusableCell(withIdentifier: Cell.className, for: indexPath) as? Cell
    }
    
    // MARK: - Convenience methods

    func register(_ nibAndReuse: String) {
        register(UINib(nibName: nibAndReuse, bundle: .main), forCellReuseIdentifier: nibAndReuse)
    }

    func register(multiple: String...) {
        multiple.forEach { register($0) }
    }
    
    func returnIndexPath(cell: UITableViewCell) -> IndexPath?{
        guard let indexPath = self.indexPath(for: cell) else {
            return nil
        }
        return indexPath
    }
}

extension UITableViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension NSObject {
    
    @objc class var className: String {
        String(describing: self)
    }
    
    var className: String {
        String(describing: type(of: self))
    }
}
