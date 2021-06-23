//
//  ViewController.swift
//  DemoApp1
//
//  Created by Dinesh Tanwar on 22/06/21.
//

import UIKit

class ViewController: UIViewController, didSaveItemDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    var itemVM = TaskItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
    }
    
    func setupUI() {
        
//        navigationController?.navigationBar.barTintColor = UIColor.green
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.title = "My Reminder"
        
        tblView.delegate = self
        tblView.dataSource = self
        
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = UITableView.automaticDimension
        tblView.tableFooterView = UIView(frame: .zero)
    }
    
    private func getData() {
        itemVM.fetchTaskData {
            [weak self] in
            DispatchQueue.main.async {
                self?.tblView.delegate = self
                self?.tblView.dataSource = self
                self?.tblView.reloadData()
            }
        }
    }
    
    @IBAction func addNewTask(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "AddItemVC") as! AddItemVC
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .formSheet
        navVC.isModalInPresentation = true
        self.navigationController?.present(navVC, animated: true, completion:nil)
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
            cell.btnTasks.setTitle("\(itemVM.todays.count)", for: .normal)
        }
        else if indexPath.row == 1 {
            cell.lblDays.text = "Tomorrow"
            cell.btnTasks.setTitle("\(itemVM.tommTasks.count)", for: .normal)
        }
        else {
            cell.lblDays.text = "Upcoming"
            cell.btnTasks.setTitle("\(itemVM.laterTask.count)", for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/3
    }
    
    //DidSaveDelegate
    func itemSaved(){
        print("Refresh the list")
        getData()
    }
}
