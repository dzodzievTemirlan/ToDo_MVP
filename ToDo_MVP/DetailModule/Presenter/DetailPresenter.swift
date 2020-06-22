//
//  DetailPresenter.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 20.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import Foundation

protocol DetailViewProtocol: class{
    func setCategory(title: String?, image: String?)
}
protocol  DetailViewPresenterProtocol: class{
    
    init(view: DetailViewProtocol,parseJsonService: ParseJsonProtocol, router: RouterProtocol,title: String?, image: String?)
    func setCategory()
    func tap()
}

class DetailPresenter: DetailViewPresenterProtocol{
  
    weak var view: DetailViewProtocol?
    let parseJson: ParseJsonProtocol!
    var router: RouterProtocol?
    var title: String?
    var image: String?
    
    required init(view: DetailViewProtocol, parseJsonService: ParseJsonProtocol, router: RouterProtocol,title: String?, image: String?) {
        self.view = view
        self.parseJson = parseJsonService
        self.router = router
        self.title = title
        self.image = image
    }
    
    func setCategory() {
        self.view?.setCategory(title: title, image: image)
    }
    func tap() {
        router?.popToRoot()
      }
      
    
    
}


