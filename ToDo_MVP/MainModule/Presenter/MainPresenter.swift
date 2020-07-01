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
    init(view: MainViewProtocol,parseJsonService: ParseJsonProtocol, router: RouterProtocol, firstStartService: FirstStartProtocol, coreDataService: CoreDataServiceProtocol)
    var categories: CategoryList? {get set}
    var taskCount: Int? {get set}
    var indexPath:IndexPath? {get set}
    func getCategories()
    func tapOnTheCell(title: String?, image: String?)
    func tapOnAddTask()
    func getTaskCount(indexPath: IndexPath)// -> Int
}


class MainPresenter: MainViewPresenterProtocol {
    var indexPath: IndexPath?
    weak var view: MainViewProtocol?
    let parseJsonService: ParseJsonProtocol
    var categories: CategoryList?
    var router: RouterProtocol?
    var firstStartService: FirstStartProtocol?
    var coreDataService: CoreDataServiceProtocol?
    var taskCount: Int?
    
    required init(view: MainViewProtocol,parseJsonService: ParseJsonProtocol, router: RouterProtocol, firstStartService: FirstStartProtocol, coreDataService: CoreDataServiceProtocol) {
        self.view = view
        self.parseJsonService = parseJsonService
        self.router = router
        self.firstStartService = firstStartService
        self.coreDataService = coreDataService
        getCategories()
//        NotificationCenter.default.addObserver(self, selector: #selector(UpdateCV), name: Notification.Name(rawValue: "com.dztemirlan.UpdateCollectionView"), object: nil)
    }
    
    
//    @objc func UpdateCV(){
//        coreDataService?.fetchCategory(complition: { (categories) in
//            if categories![self.indexPath!.row].label == "All"{
//                self.coreDataService?.fetchTask("All", complition: { (tasks) in
//                    self.taskCount = tasks?.count
//                })
//            }else{
//                self.taskCount = categories![self.indexPath!.row].childTask?.count
//            }
//        })
//    }
    
    func getTaskCount(indexPath: IndexPath){
        coreDataService?.fetchCategory(complition: { (categories) in
            if categories![indexPath.row].label == "All"{
                self.coreDataService?.fetchTask("All", complition: { (tasks) in
                    self.taskCount = tasks?.count
                })
            }else{
                self.taskCount = categories![indexPath.row].childTask?.count
            }
        })
        
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
