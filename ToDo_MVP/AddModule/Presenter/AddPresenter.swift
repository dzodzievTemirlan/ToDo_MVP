//
//  AddPresenter.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 21.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

protocol AddViewProtocol: class {
    func showDate()
    
}

protocol getDateDelegate: class {
    func getData(date: Date)
}


protocol AddViewPresenterProtocol: getDateDelegate {
    init(view: AddViewProtocol, router: RouterProtocol)
    func showPopUp()
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
    
    func getData(date: Date) {
        
        let currentDate = date
        let dateFormater = DateFormatter()
        dateFormater.timeZone = TimeZone(abbreviation: "MSK")
        dateFormater.locale = NSLocale.current
        dateFormater.dateFormat = "dd MMMM HH:mm"
        let strDate = dateFormater.string(from: currentDate)
        print(strDate)
    }
    
    func showPopUp() {
        router?.showPopUp()
    }
    
}
