//
//  MainCollectionViewCell.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 19.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    let categoryImage = UIImageView(frame: CGRect(x: 10, y: 20, width: 50, height: 50))
    let categoryTitle = UILabel(frame: CGRect(x: 13, y: 70, width: 50, height: 50))
    let countTask = UILabel(frame: CGRect(x: 13, y: 95, width: 50, height: 50))
    
    var catTitle: String?
    var catImage: String?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let title = catTitle else {return}
        guard let image = catImage else {return}
        categoryTitle.text = title
        categoryImage.image = UIImage(named: image)
        addSomeObjects()
    }
    
    fileprivate func addSomeObjects() {
        categoryTitle.tintColor = .black
        categoryTitle.font = .boldSystemFont(ofSize: 16)
        countTask.tintColor = .black
        countTask.font = .systemFont(ofSize: 12)
        addSubview(categoryTitle)
        addSubview(countTask)
        addSubview(categoryImage)
    }
    
}


