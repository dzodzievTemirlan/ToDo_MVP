//
//  MainPresenter.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 19.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import Foundation

protocol MainViewProtocol: class {
    func success()
    func failure(_ error: Error)
}
protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol,parseJsonService: ParseJsonProtocol, router: RouterProtocol, firstStartService: FirstStartProtocol)
    func getCategories()
    var categories: CategoryList? {get set}
    func tapOnTheCell(title: String?, image: String?)
    func tapOnAddTask()
    
}


class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let parseJsonService: ParseJsonProtocol
    var categories: CategoryList?
    var router: RouterProtocol?
    var firstStartService: FirstStartProtocol?
    
    required init(view: MainViewProtocol,parseJsonService: ParseJsonProtocol, router: RouterProtocol, firstStartService: FirstStartProtocol) {
        self.view = view
        self.parseJsonService = parseJsonService
        self.router = router
        self.firstStartService = firstStartService
        getCategories()
    }
    
    func tapOnTheCell(title: String?, image: String?) {
        router?.showDetail(title: title, image: image)
    }
    
    func tapOnAddTask() {
        router?.showAddTaskView()
    }
    func getCategories() {
        parseJsonService.getData { [weak self] (result) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let categories):
                    self.categories = categories
                    self.firstStartService?.firstStart(categoryList: categories)
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error)
                }
            }
        }
    }
}
