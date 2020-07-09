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
    
    lazy var datePicker: DatePickerView = {
        let view = DatePickerView()
        view.getDateDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var categoryPicker: CategoryPickerView = {
        let view = CategoryPickerView()
        view.getCategoryDelegate = self
        view.getCategoruForPicker(categories: presenter.categoryList)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setButtonTitle()
        presenter.getCategories()
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
        customCancelButton()
    }
    
    fileprivate func customCancelButton(){
        navigationItem.hidesBackButton = true
        let cancelButton = UIButton(type: .system)
        cancelButton.setImage(UIImage(named: "crossBlack")?.withRenderingMode(.alwaysOriginal), for: .normal)
        cancelButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelButton)
        cancelButton.addTarget(self, action: #selector(backVC), for: .touchUpInside)
    }
    
    @objc func backVC(){
        presenter.popVC()
    }
    
    @IBAction func addDateButtonPressed(_ sender: UIButton) {
        view.addSubview(datePicker)
        datePicker.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: .zero).isActive = true
        datePicker.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: .zero).isActive = true
        datePicker.widthAnchor.constraint(equalToConstant: view.frame.width - 120).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        datePicker.layer.cornerRadius = 10
        datePicker.layer.masksToBounds = true
        textField.resignFirstResponder()
        datePicker.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        datePicker.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.visualEffectView.alpha = 1
            self.datePicker.alpha = 1
            self.datePicker.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func addCategoryButtonPressed(_ sender: UIButton) {
        view.addSubview(categoryPicker)
        categoryPicker.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: .zero).isActive = true
        categoryPicker.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: .zero).isActive = true
        categoryPicker.widthAnchor.constraint(equalToConstant: view.frame.width - 120).isActive = true
        categoryPicker.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        categoryPicker.layer.cornerRadius = 10
        categoryPicker.layer.cornerRadius = 10
        categoryPicker.layer.masksToBounds = true
        textField.resignFirstResponder()
        
        categoryPicker.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        categoryPicker.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.visualEffectView.alpha = 1
            self.categoryPicker.alpha = 1
            self.categoryPicker.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        presenter.saveTask(addCategory.titleLabel?.text, currentDesc: textField.text, date: addDateButton.titleLabel?.text)
        presenter.popVC()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "com.dztemirlan.UpdateTableView"), object: self)
    }
    
}


extension AddViewController: AddViewProtocol{
    
    func setButtonLabel(title: String?) {
        addCategory.setTitle(title, for: .normal)
    }
    
    
    func getCategory(ccategory: String) {
        addCategory.setTitle(ccategory, for: .normal)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.categoryPicker.alpha = 0
            self.categoryPicker.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.categoryPicker.removeFromSuperview()
            print("removed")
        }
    }
    
    func getDate(date: Date) {
        let currentDate = date
        let dateFormater = DateFormatter()
        dateFormater.timeZone = TimeZone(abbreviation: "MSK")
        dateFormater.locale = NSLocale.current
        dateFormater.dateFormat = "dd MMMM HH:mm"
        let strDate = dateFormater.string(from: currentDate)
        addDateButton.setTitle(strDate, for: .normal)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.datePicker.alpha = 0
            self.datePicker.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.datePicker.removeFromSuperview()
            print("removed")
        }
    }
    
    
}

