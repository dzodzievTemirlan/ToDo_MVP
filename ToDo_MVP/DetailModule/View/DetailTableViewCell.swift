//
//  DetailViewCell.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 26.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

let falseName = Notification.Name(rawValue: "com.dztemirlan.False")
let trueName = Notification.Name(rawValue: "com.dztemirlan.True")

class DetailTableViewCell: UITableViewCell {
    var currentTask: Tasks?
    let taskDescLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let checkboxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(taskDescLabel)
        taskDescLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        taskDescLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        addSubview(dateLabel)
        dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        dateLabel.topAnchor.constraint(equalTo: taskDescLabel.bottomAnchor, constant: 10).isActive = true
        addSubview(checkboxButton)
        checkboxButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkboxButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        checkboxButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        checkboxButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        checkboxButton.addTarget(self, action: #selector(checkboxUpdate), for: .touchUpInside)
        
        
    }
    
    @objc func checkboxUpdate(){
        
        if checkboxButton.isSelected == false{
            NotificationCenter.default.post(name: trueName, object: self)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "com.dztemirlan.UpdateTableView"), object: self)
            checkboxButton.isSelected = true
        }else{
            NotificationCenter.default.post(name: falseName, object: self)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "com.dztemirlan.UpdateTableView"), object: self)
            checkboxButton.isSelected = false
        }
    }
}
