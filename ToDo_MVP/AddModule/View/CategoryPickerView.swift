//
//  CategoryPicker.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 25.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

protocol GetCategoryForButtonDelegate {
    func getCategory(ccategory: String)
}
protocol GetCategoryForPickerDelegate {
    func getCategoruForPicker(categories:[Categories]?)
    
}

class CategoryPickerView: UIView {
    
    var getCategoryDelegate: GetCategoryForButtonDelegate!
    var categoryList = [String]()
    
    var coreDataService: CoreDataServiceProtocol!
    
    let popUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Category"
        label.font = UIFont(name: "System", size: 24)
        label.backgroundColor = UIColor(red: 99/255, green: 133/255, blue: 247/255, alpha: 1)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var categoryPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.delegate = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 99/255, green: 133/255, blue: 247/255, alpha: 1)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(popUpLabel)
        popUpLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        popUpLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        popUpLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        popUpLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(categoryPicker)
        categoryPicker.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        categoryPicker.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        categoryPicker.topAnchor.constraint(equalTo: popUpLabel.bottomAnchor).isActive = true
        categoryPicker.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        categoryPicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        addSubview(addButton)
        addButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        addButton.layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleDismissal(){
        getCategoryDelegate.getCategory(ccategory: UserDefaults.standard.string(forKey: "currentCategory")!)
    }
    
}


extension CategoryPickerView: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        guard let count = presenter?.categoryList?.count else{return 0}
        return categoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        guard let categories = presenter?.categoryList else {return "?"}
        return categoryList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        guard let currentCategory = presenter?.categoryList else{return}
//        let selectedCategory = currentCategory[row]
//        UserDefaults.standard.set(selectedCategory, forKey: "currentCategory")
    }
    

    
}

extension CategoryPickerView: GetCategoryForPickerDelegate{
    func getCategoruForPicker(categories: [Categories]?) {
        for i in 0..<categories!.count{
            if categories![i].label == "All"{
                continue
            }else{
                categoryList.append(categories![i].label!)
            }
            
        }
    }
    
}

