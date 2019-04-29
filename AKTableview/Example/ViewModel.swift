//
//  ViewModel.swift
//  AKTableview
//
//  Created by Karthi Anandhan on 30/09/18.
//  Copyright © 2018 karthi. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

struct SectionOfList {
    var header: String
    var items: [String]
}

extension SectionOfList: SectionModelType {
    typealias Item = String
    
    init(original: SectionOfList, items: [Item]) {
        self = original
        self.items = items
    }
}

class ViewModel: AKBaseTableViewModel {
    var listOfObject : Variable<[SectionOfList]>!
    override init() {
        super.init()
       setInitialDeclarations()
    }
    func setInitialDeclarations() {
        listOfObject = Variable.init([])
        listOfObject.value.append(SectionOfList(header: "", items: []))
        listOfObject.value[0].items = []
        contactTableState = .notLoaded
    }
    func getFeedForIndexPath(index : Int) -> String {
        return self.listOfObject.value[0].items[index]
    }
    func getData(){
        self.contactTableState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let animals = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
            self.listOfObject.value[0].header = "sample header"
            self.listOfObject.value[0].items = animals
            self.contactTableState = .loaded // chnage this state and get the various output
//             self.contactTableState = .error
        }
    }
}
