//
//  AKProgressView.swift
//  AKTableview
//
//  Created by Karthi Anandhan on 22/09/18.
//  Copyright © 2018 karthi. All rights reserved.
//

import Foundation

import SVProgressHUD

class AKProgressView: NSObject {
    class func initialSetup(){
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setForegroundColor(UIColor.red)
    }
    class func showProgress() {
        SVProgressHUD.show()
    }
    
    class  func hideProgress() {
        SVProgressHUD.dismiss()
    }
}
