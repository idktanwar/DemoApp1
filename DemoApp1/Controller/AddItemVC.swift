//
//  AddItemVC.swift
//  DemoApp1
//
//  Created by Dinesh Tanwar on 22/06/21.
//

import UIKit

protocol didSaveItemDelegate: AnyObject{
    func itemSaved()
}

class AddItemVC: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtViewDesc: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: didSaveItemDelegate?
    
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        self.title = "Add New Task"
        
        let cancelButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissController))
        self.navigationItem.leftBarButtonItem  = cancelButtonItem
        
        let saveButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTaskItem))
        self.navigationItem.rightBarButtonItem  = saveButtonItem
        
    }
   
    @IBAction func DateChanged(_ sender: UIDatePicker) {
        date = self.datePicker.date
    }
    
    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTaskItem(){
        //save if there is the title atleast for task
        
        if txtTitle.text?.isEmpty ?? true {
            openAlert(title: "Alert", message: "Please add atleast title to task item.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay pressed")
                return
            }])
        }
        
        if Calendar.current.isDateInYesterday(date) {
            openAlert(title: "Alert", message: "Please select future date", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay pressed")
                return
            }])
        }
        
        else {
            self.dismiss(animated: true) {
                //save to DB
                
                let date  = self.date
                let descText = self.txtViewDesc.text ?? ""
                let title = self.txtTitle.text!
                
                let task = TaskItem(title: title, description: descText, date: date, iscompleted: false)
                let isSaved = CoreDataManager.sharedInstance.addNewTaskItem(taskItem: task)
                
                if isSaved && self.delegate != nil {
                    self.delegate?.itemSaved()
                }
            }
        }
        
    }
    
}
