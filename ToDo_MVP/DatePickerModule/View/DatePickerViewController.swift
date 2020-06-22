//
//  DatePickerViewController.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 22.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    var delegate: getDateDelegate!
    
    @IBOutlet weak var viewBackGround: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addButton: UIButton!
    
    var presenter: DatePickerPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    

}

extension DatePickerViewController: DatePickerProtocol{
    func getDate() {
        
    }
}
