//
//  ToDo_MVP.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 19.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

protocol Builder {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(title: String?, image: String?, router: RouterProtocol) -> UIViewController
    func createAddViewModule(router: RouterProtocol) -> UIViewController
    func createDatePickerModule(router: RouterProtocol) -> UIViewController
}

class ModelBuilder: Builder{
    
    func createDatePickerModule(router: RouterProtocol) -> UIViewController {
        let view = DatePickerViewController()
        let presenter = DatePickerPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let parseService = ParseService()
        let coreDataService = CoreDataService()
        let firstStartService = FirstStartService(coreDataService: coreDataService)
        let presenter = MainPresenter(view: view, parseJsonService: parseService, router: router, firstStartService: firstStartService )
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(title: String?, image: String?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let parseService = ParseService()
        let presenter = DetailPresenter(view: view, parseJsonService: parseService, router: router, title: title, image: image)
        view.presenter = presenter
        return view
    }
    
    func createAddViewModule(router: RouterProtocol) -> UIViewController {
        let view = AddViewController()
        let presenter = AddPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    

    
    
    
}

