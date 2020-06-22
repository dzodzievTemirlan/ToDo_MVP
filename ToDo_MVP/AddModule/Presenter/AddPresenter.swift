//
//  AddPresenter.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 21.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import Foundation

protocol AddViewProtocol: class {
    func getTaskItem(note: String?, category: String?, date: Date?)
}
protocol AddViewPresenterProtocol: class {
    init(view: AddViewProtocol, router: RouterProtocol)
    func getTaskItem()
    func tap()
}

class AddPresenter: AddViewPresenterProtocol{
    weak var view: AddViewProtocol?
    var router: RouterProtocol?
    var note: String?
    var category: String?
    var date: Date?
    
    required init(view: AddViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        
    }
    
    func getTaskItem() {
        self.view?.getTaskItem(note: note, category: category, date: date)
    }
    
    func tap() {
        router?.popVC()
    }
}
