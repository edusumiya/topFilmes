//
//  UIView+ClassName.swift
//  Timeline
//
//  Created by Eduardo Alves Sumiya on 25/07/18.
//  Copyright © 2018 ResourceIt. All rights reserved.
//

import UIKit

extension UIView {
    class func className() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

