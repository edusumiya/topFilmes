//
//  TableView.swift
//  Timeline
//
//  Created by resource on 26/06/18.
//  Copyright © 2018 ResourceIt. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeue<T: UITableViewCell>(index: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.className(), for: index) as? T
    }
    
}

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(index: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: T.className(), for: index) as? T
    }
}
