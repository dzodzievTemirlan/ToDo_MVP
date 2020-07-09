//
//  DetailViewController.swift
//  ToDo_MVP
//
//  Created by Temirlan Dzodziev on 20.06.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskCount: UILabel!
    @IBOutlet weak var addNewTaskButton: UIButton!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeButton(button: addNewTaskButton)
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "Cell")
        presenter.setCategory()
        tableView.layer.cornerRadius = tableView.bounds.width / 17
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        customCancelButton()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: Notification.Name(rawValue: "com.dztemirlan.UpdateTableView"), object: nil)
    }
    
    fileprivate func customCancelButton(){
        navigationItem.hidesBackButton = true
        let cancelButton = UIButton(type: .system)
        cancelButton.setImage(UIImage(named: "crossWhite")?.withRenderingMode(.alwaysOriginal), for: .normal)
        cancelButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelButton)
        cancelButton.addTarget(self, action: #selector(backVC), for: .touchUpInside)
    }
    @objc func backVC(){
        presenter.popVC()
        NotificationCenter.default.post(name: Notification.Name("com.dztemirlan.UpdateCount"), object: nil)
    }
    
    @IBAction func addNewTaskButtonPressed(_ sender: UIButton) {
        presenter.addNewTask(title: categoryTitle.text)
    }
    
    func customizeButton(button: UIButton){
        button.layer.cornerRadius = button.bounds.width / 2
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 15
        button.layer.shadowPath = UIBezierPath(ovalIn: button.bounds).cgPath
    }
    
    @objc func updateTableView(){
        tableView.reloadData()
    }
}

extension DetailViewController: DetailViewProtocol{
    
    func setCategory(title: String?, image: String?) {
        guard let unwrappedTitle = title else {return}
        guard let unwrappedImage = image else {return}
        categoryTitle.text = unwrappedTitle
        categoryImage.image = UIImage(named: "\(unwrappedImage)2")
    }
    
    func updateCheckbox(_ bool: Bool, _ task: Tasks) {
        presenter.updateCheckBoxButton(bool, task)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "com.dztemirlan.UpdateTableView"), object: nil)
    }
}
//MARK:-TableViewDataSource
extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter.tasksList?.count else {return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailTableViewCell
        guard let desc = presenter.tasksList?[indexPath.row].desc else{return cell}
        guard let date = presenter.tasksList?[indexPath.row].date else {return cell}
        guard let checkBox = presenter.tasksList else {return cell}
        cell.currentTask = presenter.tasksList?[indexPath.row]
        cell.catName = presenter.tasksList?[indexPath.row].parentCategory?.label
        cell.taskDescLabel.text = desc
        cell.dateLabel.text = dateToString(date: date)
        cell.checkboxButton.setImage(UIImage(named: checkboxImage(checkBox, indexPath)), for: .normal)
        taskCount.text = "\(presenter.tasksList!.count) tasks"
        cell.layer.borderColor = UIColor.white.cgColor
        cell.checkBoxUpdate = self
        cell.task = presenter.tasksList?[indexPath.row]
        return cell
    }
    
    fileprivate func dateToString(date: Date) -> String{
        let dateFormater = DateFormatter()
        dateFormater.timeZone = TimeZone(abbreviation: "MSK")
        dateFormater.locale = NSLocale.current
        dateFormater.dateFormat = "dd MMMM HH:mm"
        let dateCurrent = dateFormater.string(from: date)
        return dateCurrent
    }
    
    fileprivate func checkboxImage(_ task: [Tasks], _ index: IndexPath) -> String{
        switch task[index.row].done {
        case true:
            return "check"
        case false:
            return "uncheck"
        }
    }
}

//MARK:-TableViewDelegate
extension DetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(integerLiteral: 70)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, complition) in
            self.presenter.deleteTask(task: self.presenter.tasksList![indexPath.row])
            complition(true)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "com.dztemirlan.UpdateTableView"), object: nil)
        }
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
    
    //MARK:-Header Animation
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let headerViewMinHeight: CGFloat = presenter.height! + 100
        print(viewHeight.constant)
        let offsetY: CGFloat = scrollView.contentOffset.y
        let newHeaderViewHeight: CGFloat = viewHeight.constant - offsetY
        
        if newHeaderViewHeight > 350{
            navigationItem.title = ""
            viewHeight.constant = 350
            print(newHeaderViewHeight)
            
        }else if newHeaderViewHeight < headerViewMinHeight{
            viewHeight.constant = headerViewMinHeight
            print(viewHeight.constant)
            navigationItem.title = categoryTitle.text
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
        }else{
            viewHeight.constant = newHeaderViewHeight
            scrollView.contentOffset.y = 0
        }
        let dinamicAlpha = ((viewHeight.constant - 350) / headerViewMinHeight) + 1
        setAnimation(with: dinamicAlpha, duration: 0.5)
    }
    fileprivate func setAnimation(with alpha: CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.categoryImage.alpha = alpha
            self.categoryTitle.alpha = alpha
            self.taskCount.alpha = alpha
        }
    }
}
