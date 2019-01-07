//
//  UIColor+RGB.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 06/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(rgb: Int) {
        self.init(
            red:   (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue:  rgb & 0xFF
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        let kRGBMax:Int = 255
        
        assert(red   >= 0 && red   <= kRGBMax, "Invalid red component")
        assert(green >= 0 && green <= kRGBMax, "Invalid green component")
        assert(blue  >= 0 && blue  <= kRGBMax, "Invalid blue component")
        
        self.init(red:   CGFloat(red)   / CGFloat(kRGBMax),
                  green: CGFloat(green) / CGFloat(kRGBMax),
                  blue:  CGFloat(blue)  / CGFloat(kRGBMax), alpha: 1.0)
    }
}
