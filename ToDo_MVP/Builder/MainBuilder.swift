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
    func createAddViewModuleFromOneCategory(router: RouterProtocol, title: String?) -> UIViewController
}

class ModelBuilder: Builder{
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let parseService = ParseService()
        let coreDataService = CoreDataService()
        let firstStartService = FirstStartService(coreDataService: coreDataService)
        let presenter = MainPresenter(view: view, parseJsonService: parseService, router: router, firstStartService: firstStartService, coreDataService: coreDataService)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(title: String?, image: String?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let parseService = ParseService()
        let coreDataService = CoreDataService()
        let presenter = DetailPresenter(view: view, parseJsonService: parseService, router: router, title: title, image: image, coreDataService: coreDataService)
        view.presenter = presenter
        return view
    }
    
    func createAddViewModule(router: RouterProtocol) -> UIViewController {
        let view = AddViewController()
        let coreDataService = CoreDataService()
        var title: String?
        let presenter = AddPresenter(view: view, router: router, coreDataService: coreDataService, title: title ?? "Add Category")
        view.presenter = presenter
        return view
    }
    func createAddViewModuleFromOneCategory(router: RouterProtocol, title: String?) -> UIViewController {
        let view = AddViewController()
        let coreDataService = CoreDataService()
        let presenter = AddPresenter(view: view, router: router, coreDataService: coreDataService, title: title)
        view.presenter = presenter
        return view
    }
    
    
}

