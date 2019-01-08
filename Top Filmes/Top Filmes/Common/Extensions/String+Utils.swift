//
//  String+Utils.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 08/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        get {
            return NSLocalizedString(self, comment: self)
        }
    }
}
