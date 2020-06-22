//
//  DatePickerView.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 22.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

protocol DatePickerProtocol: class{
    func showPopUp(viewOut: UIView) -> UIView
}
protocol DatePickerPresenterProtocol: DatePickerProtocol {
    init(view: DatePickerProtocol, router: RouterProtocol)
}

class DatePickerPresenter: DatePickerPresenterProtocol{
    weak var view: DatePickerProtocol?
    let router: RouterProtocol?
    required init(view: DatePickerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func showPopUp(viewOut: UIView) -> UIView {
        var viewIn = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        viewIn.centerYAnchor.constraint(equalToSystemSpacingBelow: viewOut.centerYAnchor, multiplier: .zero).isActive = true
        viewIn.centerXAnchor.constraint(equalToSystemSpacingAfter: viewOut.centerXAnchor, multiplier: .zero).isActive = true
        viewIn.layer.backgroundColor = UIColor.red.cgColor
        
        return viewIn
    }
    
    
}
