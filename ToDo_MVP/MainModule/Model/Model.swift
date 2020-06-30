//
//  Model.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 19.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import Foundation

struct CategoryList: Codable{
    let Category: [TasksList]
}
struct TasksList: Codable{
    let label: String
    let image: String
}
