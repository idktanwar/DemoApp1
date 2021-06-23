//
//  TaskDetailVC.swift
//  DemoApp1
//
//  Created by Dinesh Tanwar on 23/06/21.
//

import UIKit

class TaskDetailVC: UIViewController {

    //MARK:- Property
    @IBOutlet weak var tblView: UITableView!
    var taskItems = [TaskItem]()
    
    //MARK:- LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    //MARK:- Helper Method

    private func setupUI() {

        tblView.delegate = self
        tblView.dataSource = self
        
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = UITableView.automaticDimension
        tblView.tableFooterView = UIView(frame: .zero)
        
    }
}

//MARK:- Tableview Datasource & Delegate

extension TaskDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskDetailTableViewCell", for: indexPath) as! TaskDetailTableViewCell
        cell.lblTitle.text = taskItems[indexPath.row].title
        cell.lblDesc.text = taskItems[indexPath.row].description
        cell.lblDate.text = taskItems[indexPath.row].date.getDate()

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             let taskItem = taskItems[indexPath.row]
             if CoreDataManager.sharedInstance.removeTaskItem(with: taskItem) {
                 taskItems.remove(at: indexPath.row)
                 tableView.deleteRows(at: [indexPath], with: .fade)
                 DispatchQueue.main.async {
                     self.tblView.reloadData()
                 }
             }
         }
     }

}
