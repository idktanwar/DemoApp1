//
//  ViewController.swift
//  DemoApp1
//
//  Created by Dinesh Tanwar on 22/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        navigationController?.navigationBar.barTintColor = UIColor.green
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]

        tblView.delegate = self
        tblView.dataSource = self
        
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = UITableView.automaticDimension
        tblView.tableFooterView = UIView(frame: .zero)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DaysTableViewCell", for: indexPath) as! DaysTableViewCell
        if indexPath.row == 0 {
            cell.lblDays.text = "Todays"
        }
        else if indexPath.row == 1 {
            cell.lblDays.text = "Tomorrow"
        }
        else {
            cell.lblDays.text = "Later"
        }
        cell.btnTasks.setTitle("12", for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/3
    }
    
}
