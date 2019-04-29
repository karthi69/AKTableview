//
//  AKTableview.swift
//  AKTableview
//
//  Created by Karthi Anandhan on 22/09/18.
//  Copyright © 2018 karthi. All rights reserved.
//

import Foundation


import Foundation
import UIKit

protocol AKTableViewDelegate: class {
    func imageForState(_ state: AKTableViewState) -> UIImage?
    func infoForState(_ state: AKTableViewState) -> String?
    func actionTextForState(_ state: AKTableViewState) -> String?
    func performAction(_ state: AKTableViewState )
}

class AKBaseTableView: UITableView {
    
    weak var viewDelegate: AKTableViewDelegate?
    private var placeHolderView: AKPlaceHolderView?
    var feedViewModel : AKBaseTableViewModel =  AKBaseTableViewModel(){
        didSet {
            feedViewModel.interfaceDelegate = self
        }
    }
    
    override func awakeFromNib() {
        addPlaceHolderView()
        super.awakeFromNib()
    }
    
    private func updateUI() {
    
    }
    private func showLoading()
    {
        AKProgressView.showProgress()
    }
    private func hideLoading(){
        AKProgressView.hideProgress()
    }
    
    private func addPlaceHolderView() {
        let placeHolderNib = UINib(nibName: String(describing: AKPlaceHolderView.self), bundle: nil)
        placeHolderView = placeHolderNib.instantiate(withOwner: nil, options: nil)[0] as? AKPlaceHolderView
        placeHolderView?.delegate = self
        placeHolderView?.alpha = 0.0
        placeHolderView.map {
            self.backgroundView = placeHolderView
            $0.frame = self.bounds
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

extension AKBaseTableView: AKPlaceholderViewDelegate {
    func performAction() {
        viewDelegate?.performAction(feedViewModel.contactTableState)
    }
}

extension AKBaseTableView : AKBaseTableViewInterfaceUpdate{
    func updateInterface() {
        switch feedViewModel.contactTableState  {
        case .loading:
            placeHolderView?.hide()
            showLoading()
        case .loaded:
            placeHolderView?.hide()
            hideLoading()
        default:
            hideLoading()
            placeHolderView.map { bringSubview(toFront: $0) }
            placeHolderView?.configure(image: viewDelegate?.imageForState(feedViewModel.contactTableState),
                                       info: viewDelegate?.infoForState(feedViewModel.contactTableState),
                                       actionText: viewDelegate?.actionTextForState(feedViewModel.contactTableState))
        }
    }
}
