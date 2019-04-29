//
//  AKPlaceholderview.swift
//  AKTableview
//
//  Created by Karthi Anandhan on 22/09/18.
//  Copyright © 2018 karthi. All rights reserved.
//

import Foundation


import Foundation
import UIKit

protocol AKPlaceholderViewDelegate: class {
    func performAction()
}

class AKPlaceHolderView: UIView {
    
    weak var delegate: AKPlaceholderViewDelegate?
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    
    func configure(image: UIImage?, info: String?, actionText: String?) {
        reveal()
        imageView.image = image
        infoLabel.text = info
        actionButton.setTitle(actionText, for: .normal)
    }
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        delegate?.performAction()
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
