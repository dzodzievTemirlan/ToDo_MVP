//
//  CoreDataServicce.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 21.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit
import CoreData

protocol SaveCategoriesProtocol: class{
    func saveCategories(categoryItem: Tasks)
}

class CoreDataService: SaveCategoriesProtocol{
    func saveCategories(categoryItem: Tasks) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let categories = Categories(context: context)
        categories.label = categoryItem.label
        categories.image = categoryItem.image
        do {
            try context.save()
        } catch{
            print("error with saving categories")
        }
    }
}
