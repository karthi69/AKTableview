//
//  ViewController.swift
//  AKTableview
//
//  Created by Karthi Anandhan on 22/09/18.
//  Copyright © 2018 karthi. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ViewController: UIViewController {
    @IBOutlet weak var tableview: AKBaseTableView!
    
    var viewModel :ViewModel?
    let disposeBag = DisposeBag()
    let cellReuseIdentifier = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDeclaration()
        setupTableview()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func initialDeclaration() {
         viewModel = ViewModel()
        if let model =  viewModel{
            tableview.feedViewModel = model
            tableview.viewDelegate = self
            viewModel?.getData()
        }
        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    func setupTableview() {
    let dataSource = getDataSource()
    let data = viewModel?.listOfObject?.asObservable()
    data?.bind(to: tableview.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    func getDataSource() -> RxTableViewSectionedReloadDataSource<SectionOfList>{
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfList>(
            configureCell: {(dataSource, table, indexPath, customer)  -> UITableViewCell in
                let cell:UITableViewCell = self.tableview.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) ?? UITableViewCell()
                let feedData = self.viewModel?.getFeedForIndexPath(index: indexPath.row) ?? ""
                cell.textLabel?.text = feedData
                 cell.textLabel?.textAlignment = .center
                return cell
        },
            canEditRowAtIndexPath: { (_, _) in
                return true
        },
            canMoveRowAtIndexPath: { _, _ in
                return false
        })
        return dataSource
    }
}

extension ViewController : AKTableViewDelegate{
   
    func infoForState(_ state: AKTableViewState) -> String? {
        if(state == .noData){
            return TableStateTitleConstants.emptyContentTitle
        }
        else if(state == .error){
            return TableStateTitleConstants.errorTitle
        }
        else if(state == .noConnection ){
            return TableStateTitleConstants.noInternetInfo
        }
        return nil
    }
    func actionTextForState(_ state: AKTableViewState) -> String? {
        switch state {
        case .error, .noConnection :
            return TableStateTitleConstants.refreshTitle
        case .noData :
            return nil
        default:
            return nil
        }
    }
    
    func performAction(_ state: AKTableViewState) {
       
    }
    
    func imageForState(_ state: AKTableViewState) -> UIImage? {
        if(state == .noData){
            return UIImage.init(named: "emptydata")
        }
        else if(state == .error){
            return UIImage.init(named: "emptydata")
        }
        else if(state == .noConnection ){
            return UIImage.init(named: "nointernet")
        }
        else if(state == .loaded){
            return UIImage.init(named: "internetConnect")
        }
        
        return nil
    }
}

