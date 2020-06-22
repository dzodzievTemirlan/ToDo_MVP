//
//  DatePickerView.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 22.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

class DatePickerView: UIView {

    var presenter: DatePickerPresenterProtocol!
    
    override func addSubview(_ view: UIView) {
        addSubview(presenter.showPopUp(viewOut: view))
    }

}
