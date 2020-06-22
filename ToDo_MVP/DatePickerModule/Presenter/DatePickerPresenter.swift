//
//  DatePickerPresenter.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 22.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import Foundation

protocol DatePickerProtocol: class{
    func getDate()
}

protocol DatePickerViewProtocol: class {
    init(view: DatePickerProtocol,router: RouterProtocol)
    
    
}


class DatePickerPresenter: DatePickerViewProtocol {
    
    weak var view: DatePickerProtocol?
    let router: RouterProtocol?
    required init(view: DatePickerProtocol, router: RouterProtocol) {
        self.router = router
        self.view = view
    }
    
    
}



