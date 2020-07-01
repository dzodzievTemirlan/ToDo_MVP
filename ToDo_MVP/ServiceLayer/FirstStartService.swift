//
//  FirstStartService.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 21.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import Foundation

protocol FirstStartProtocol{
    func firstStart(categoryList: CategoryList?)
    init(coreDataService: CoreDataServiceProtocol)
}

class FirstStartService:FirstStartProtocol{
    var coreDataService: CoreDataServiceProtocol?
    
    required init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
    }
    func firstStart(categoryList: CategoryList?) {
        if UserDefaults.standard.bool(forKey: "isStarted") == true{
            print("App already started")
        }else{
            UserDefaults.standard.set(true,forKey: "isStarted")
            for category in categoryList!.Category.self{
                coreDataService?.saveCategories(categoryItem: category)
            }
        }
    }
}
