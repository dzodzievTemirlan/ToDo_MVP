//
//  DatePicker.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 22.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

protocol GetDateDelegate: class{
    func getDate(date: Date)
}

class DatePickerView: UIView {
    
    var getDateDelegate: GetDateDelegate?
    
    let popUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Date"
        label.font = UIFont(name: "System", size: 24)
        label.backgroundColor = UIColor(red: 99/255, green: 133/255, blue: 247/255, alpha: 1)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.locale = Locale(identifier: "Russia")
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
        
        addSubview(datePicker)
        datePicker.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: popUpLabel.bottomAnchor).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        addSubview(addButton)
        addButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
        addButton.layer.cornerRadius = 5
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleDismissal(){
        getDateDelegate?.getDate(date: datePicker.date)
    }
    
}
