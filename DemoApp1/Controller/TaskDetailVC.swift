//
//  TaskDetailVC.swift
//  DemoApp1
//
//  Created by Dinesh Tanwar on 23/06/21.
//

import UIKit

class TaskDetailVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var taskItems = [TaskItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {        
        tblView.delegate = self
        tblView.dataSource = self
        
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = UITableView.automaticDimension
        tblView.tableFooterView = UIView(frame: .zero)
        
    }
}

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

}
