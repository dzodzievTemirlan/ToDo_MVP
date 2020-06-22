//
//  AddViewController.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 21.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addDateButton: UIButton!
    @IBOutlet weak var addCategory: UIButton!
    
    var presenter: AddViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func addDateButtonPressed(_ sender: UIButton) {
        presenter.showPopUp()
    }
    
    @IBAction func addCategoryButtonPressed(_ sender: Any) {
        
    }
}

extension AddViewController: AddViewProtocol{

    func showDate() {
        
    
    }
    
    
}
