//
//  Utility.swift
//  AKTableview
//
//  Created by Karthi Anandhan on 22/09/18.
//  Copyright © 2018 karthi. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    class func animate(_ animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: AKAnimationDuration.defaultDuration.rawValue,
                       animations: animations,
                       completion: completion)
    }
    
    func hide() {
        UIView.animate({
            self.alpha = 0.0
        }, completion: nil)
    }
    
    func reveal() {
        UIView.animate({
            self.alpha = 1.0
        }, completion: nil)
    }
}

enum AKAnimationDuration: Double {
    case defaultDuration = 0.3
}
