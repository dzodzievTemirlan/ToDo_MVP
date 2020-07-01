//
//  ViewController.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 17.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addTaskButton: UIButton!
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        paddingCells()
        customizeButton(button: addTaskButton)
        navigationItem.title = "Lists"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    @IBAction func addTaskButtonPressed(_ sender: UIButton) {
        presenter.tapOnAddTask()
    }
}

extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.categories?.Category.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! MainCollectionViewCell
        cell.catTitle = presenter.categories?.Category[indexPath.row].label
        cell.catImage = presenter.categories?.Category[indexPath.row].image
        presenter.getTaskCount(indexPath: indexPath)
        presenter.indexPath = indexPath
        cell.taskCount = presenter.taskCount
        cell.backgroundColor = .white
        cell.layer.shadowOpacity = 0.16
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 1).cgPath
        cell.layer.shadowRadius = 20
        cell.layer.shadowOffset = .zero
        return cell
    }
    
    func paddingCells(){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let padding:CGFloat = 20
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
            layout.minimumLineSpacing = 30
        }
    }
    
    func customizeButton(button: UIButton){
        button.layer.cornerRadius = button.bounds.width / 2
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 15
        button.layer.shadowPath = UIBezierPath(ovalIn: button.bounds).cgPath
    }
}

extension MainViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = presenter.categories?.Category[indexPath.row].label
        let image = presenter.categories?.Category[indexPath.row].image
        presenter.tapOnTheCell(title: title, image: image)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width / 2.5, height: 175)
    }
}


extension MainViewController: MainViewProtocol{
    func success() {
        collectionView.reloadData()
    }
    
    func failure(_ error: Error) {
        let alert = UIAlertController(title: "Data doen't come", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
