//
//  MessageUtils.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 07/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import Foundation
import UIKit

class MessageUtils {
    
    /// Shows a toast for user feedback
    ///
    /// - Parameters:
    ///   - controller: controller to show
    ///   - message: message
    ///   - seconds: seconds of showing
    static func showToast(controller: UIViewController, message: String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
