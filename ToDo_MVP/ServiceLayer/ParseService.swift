//
//  ParseService.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 19.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import Foundation

protocol ParseJsonProtocol {
    func getData(complition: @escaping(Result<CategoryList?, Error>)->Void)
}

class ParseService: ParseJsonProtocol{
    func getData(complition: @escaping (Result<CategoryList?, Error>) -> Void) {
         guard let path = Bundle.main.path(forResource: "category", ofType: "json") else{return}
               let url = URL(fileURLWithPath: path)
               do{
                   let data = try Data(contentsOf: url)
                   let categories = try JSONDecoder().decode(CategoryList.self, from: data)
                complition(.success(categories))
               }catch{
                   print("error: \(error )")
                complition(.failure(error))
               }
    }
    
    
}
