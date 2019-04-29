//
//  AKTableviewModel.swift
//  AKTableview
//
//  Created by Karthi Anandhan on 22/09/18.
//  Copyright © 2018 karthi. All rights reserved.
//

import Foundation

import Foundation
import RxSwift

enum AKTableViewState {
    case notLoaded
    case loading
    case loaded
    case error
    case noConnection
    case noData
}

protocol AKBaseTableViewInterfaceUpdate: class {
    func updateInterface()
}

class AKBaseTableViewModel: NSObject {
    
    weak var interfaceDelegate: AKBaseTableViewInterfaceUpdate?
    var contactTableState: AKTableViewState = .notLoaded {
        didSet {
            DispatchQueue.main.async {
                self.interfaceDelegate?.updateInterface()
            }
        }
    }
}
