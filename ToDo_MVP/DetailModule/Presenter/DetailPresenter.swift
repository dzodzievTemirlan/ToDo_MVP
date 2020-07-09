//
//  DetailPresenter.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 20.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

protocol DetailViewProtocol: CheckBoxUpdateProtocol{
    func setCategory(title: String?, image: String?)
    
}
protocol  DetailViewPresenterProtocol: class{
    init(view: DetailViewProtocol,parseJsonService: ParseJsonProtocol, router: RouterProtocol,title: String?, image: String?, coreDataService: CoreDataServiceProtocol)
    var tasksList: [Tasks]? {get set}
    var height: CGFloat? {get set}
    func addNewTask(title: String?)
    func setCategory()
    func getTask()
    func deleteTask(task: Tasks)
    func updateCheckBoxButton(_ bool: Bool, _ task: Tasks)
    func popVC()
}

class DetailPresenter: DetailViewPresenterProtocol{
  
    weak var view: DetailViewProtocol?
    
    let parseJson: ParseJsonProtocol!
    var router: RouterProtocol?
    var coreDataService: CoreDataServiceProtocol!
    var title: String?
    var image: String?
    var tasksList: [Tasks]?
    var height: CGFloat? = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    
    required init(view: DetailViewProtocol, parseJsonService: ParseJsonProtocol, router: RouterProtocol,title: String?, image: String?,coreDataService: CoreDataServiceProtocol) {
        self.view = view
        self.parseJson = parseJsonService
        self.coreDataService = coreDataService
        self.router = router
        self.title = title
        self.image = image
        getTask()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: Notification.Name(rawValue: "com.dztemirlan.UpdateTableView"), object: nil)
    }
    
    func setCategory() {
        self.view?.setCategory(title: title, image: image)
    }
    
    func getTask(){
        coreDataService.fetchTask(title, complition: { (result) in
            self.tasksList = result
        })
        
    }
    func deleteTask(task: Tasks) {
        coreDataService.deleteTask(task)
    }
    
    func addNewTask(title: String?) {
        router?.presentAddTaskView(title: title)
    }
    
    func updateCheckBoxButton(_ bool: Bool, _ task: Tasks) {
        guard let category = title else {return}
        if bool{
            coreDataService.updateTaskCheckbox(category, true, task)
        }else{
            coreDataService.updateTaskCheckbox(category, false, task)
        }
    }
    
    func popVC() {
        router?.popVC()
      }
      
    @objc func updateTableView(){
        coreDataService.fetchTask(title, complition: { (result) in
            self.tasksList = result
        })
    }
}

