//
//  UICollectionViewCell+Register.swift
//  Timeline
//
//  Created by resource on 21/03/18.
//  Copyright © 2018 ResourceIt. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    static func register(_ cllView: UICollectionView) {
        cllView.register(UINib(nibName: self.className(),
                               bundle: nil),
                         forCellWithReuseIdentifier: self.className())
    }
}
