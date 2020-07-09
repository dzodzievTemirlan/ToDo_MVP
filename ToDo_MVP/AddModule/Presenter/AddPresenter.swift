//
//  AddPresenter.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 21.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

protocol AddViewProtocol: GetDateDelegate, GetCategoryForButtonDelegate{
    func setButtonLabel(title: String?)
}
protocol AddViewPresenterProtocol: class {
    init(view: AddViewProtocol, router: RouterProtocol, coreDataService: CoreDataServiceProtocol, title: String?)
    var categoryList: [Categories]? {get set}
    func getCategories()
    func saveTask(_ currentCategory: String?, currentDesc: String?, date: String?)
    func popVC()
    func setButtonTitle()
}
class AddPresenter: AddViewPresenterProtocol{
    weak var view: AddViewProtocol?
    var router: RouterProtocol?
    var coreDataService: CoreDataServiceProtocol?
    var title: String?
    var categoryList: [Categories]?
    required init(view: AddViewProtocol, router: RouterProtocol, coreDataService: CoreDataServiceProtocol, title: String?) {
        self.view = view
        self.router = router
        self.coreDataService = coreDataService
        self.title = title
        getCategories()
    }
    func getCategories() {
        coreDataService?.fetchCategory { (categories) in
            self.categoryList = categories
        }
    }
    func saveTask(_ currentCategory: String?, currentDesc: String?, date: String?) {
        guard let currentDate = date else {return}
        let dateFormater = DateFormatter()
        dateFormater.timeZone = TimeZone(abbreviation: "MSK")
        dateFormater.locale = NSLocale.current
        dateFormater.dateFormat = "dd MMMM HH:mm"
        guard let dateCurrent = dateFormater.date(from: currentDate) else{return}
        guard let desc = currentDesc else {return}
        guard let category = currentCategory else {return}
        coreDataService?.saveTasks(category, desc, dateCurrent)
    }
    func popVC() {
        router?.popVC()
    }
    func setButtonTitle() {
        view?.setButtonLabel(title: title)
    }
    
}
