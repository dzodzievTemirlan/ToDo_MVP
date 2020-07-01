//
//  CoreDataServicce.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 21.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataServiceProtocol: class{
    func saveCategories(categoryItem: TasksList)
    func fetchCategory(complition: @escaping(_ categories: [Categories]?)->Void)
    func saveTasks(_ currentCategory: String, _ currentDesc: String,_ currentDate: Date)
    func fetchTask(_ currentCategory: String?, complition: @escaping(_ tasks: [Tasks]?) -> Void)
    func updateTaskCheckbox(_ ccategoryName: String, _ done: Bool, _ task: Tasks)
    func deleteTask(_ task: Tasks)
}

class CoreDataService: CoreDataServiceProtocol{
    
    
    func saveCategories(categoryItem: TasksList) {
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
    
    
    func fetchCategory(complition: @escaping ([Categories]?) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Categories> = Categories.fetchRequest()
        request.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(request)
            complition(result)
        }catch{
            complition(nil)
        }
    }
    
    func saveTasks(_ currentCategory: String, _ currentDesc: String, _ currentDate: Date) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let task = Tasks(context: context)
        
        task.desc = currentDesc
        task.date = currentDate
        task.done = false
        
        fetchCategory { (categories) in
            guard let unwrappedCategories = categories else {return}
            for category in unwrappedCategories where category.label == currentCategory{
                task.parentCategory = category
            }
        }
        do{
            try context.save()
        }catch{
            print("Error with saving tasks")
        }
    }
    
    func fetchTask(_ currentCategory: String?, complition: @escaping ([Tasks]?) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        guard let unwrappedCategory = currentCategory else {return}
        
        if unwrappedCategory == "All"{
            let request: NSFetchRequest<Tasks> = Tasks.fetchRequest()
            do{
                let result = try context.fetch(request)
                complition(result)
            } catch {
                print("Error with fetching data")
            }
        }else{
            let request: NSFetchRequest<Tasks> = Tasks.fetchRequest()
            request.returnsObjectsAsFaults = false
            let predicate = NSPredicate(format: "parentCategory.label MATCHES %@", unwrappedCategory)
            request.predicate = predicate
            
            do{
                let result = try context.fetch(request)
                complition(result)
            }catch{
                print("Error with fetching data")
            }
        }
        
    }
    
    func updateTaskCheckbox(_ categoryName: String, _ done: Bool, _ task: Tasks) {
        fetchTask(categoryName) { (tasks) in
            guard let taskList = tasks else{return}
            for taskOne in taskList where taskOne == task{
                taskOne.setValue(done, forKey: "done")
                
                do{
                    try taskOne.managedObjectContext?.save()
                }catch{
                    print("Error save Task")
                }
            }
        }
    }
    
    func deleteTask(_ task: Tasks) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        context.delete(task)
        do{
            try context.save()
        }catch{
            print("error with delete")
        }
    }
}
