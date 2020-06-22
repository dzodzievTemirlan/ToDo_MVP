//
//  DetailViewController.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 20.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskCount: UILabel!
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        presenter.setCategory()
        tableView.layer.cornerRadius = tableView.bounds.width / 17
    }
    
  

}

extension DetailViewController: DetailViewProtocol{
    func setCategory(title: String?, image: String?) {
        guard let unwrappedTitle = title else {return}
        guard let unwrappedImage = image else {return}
        categoryTitle.text = unwrappedTitle
        categoryImage.image = UIImage(named: "\(unwrappedImage)2")
        
    }
}

extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Test"
        cell.layer.borderColor = UIColor.white.cgColor
        return cell
    }
}
