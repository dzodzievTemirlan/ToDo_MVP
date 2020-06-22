//
//  Кщгеук.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 20.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? {get set}
    var assemblyBuilder: Builder? {get set}
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(title: String?, image: String?)
    func showAddTaskView()
    func popVC()
    func popToRoot()
    func showPopUp()

}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: Builder?
    init(navigationController: UINavigationController, assemblyBuilder: Builder){
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    func initialViewController() {
        if let navigationController = navigationController{
            guard let mainVC = assemblyBuilder?.createMainModule(router: self) else {return}
            navigationController.viewControllers = [mainVC]
        }
    }
    
    func showDetail(title: String?, image: String?) {
        if let navigationController = navigationController{
            guard let detailVC = assemblyBuilder?.createDetailModule(title: title, image: image, router: self) else {return}
            navigationController.pushViewController(detailVC, animated: true)
        }
    }
    
    func showAddTaskView() {
        if let navigationController = navigationController{
            guard let addTaskVC = assemblyBuilder?.createAddViewModule(router: self) else {return}
            navigationController.pushViewController(addTaskVC, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController{
            navigationController.popToRootViewController(animated: true)
        }
    }
    func popVC() {
        if let navigationController = navigationController{
            navigationController.popViewController(animated: true)
        }
    }
    
    func showPopUp() {
        if let navigationController = navigationController{
            guard let datePickerVC = assemblyBuilder?.createDatePickerModule(router: self) else{return}
            //            navigationController.isModalInPresentation = true
            navigationController.present(datePickerVC, animated: true) {
                let test = UIModalPresentationStyle.overCurrentContext.rawValue
                navigationController.modalPresentationStyle = UIModalPresentationStyle(rawValue: test)!
            }
            
            
        }
    }
    
    
    
    
    
}
