//
//  AddItemVC.swift
//  DemoApp1
//
//  Created by Dinesh Tanwar on 22/06/21.
//

import UIKit
import EventKit

protocol didSaveItemDelegate: AnyObject{
    func itemSaved()
}

class AddItemVC: UIViewController {

    //MARK:- Property
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtViewDesc: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: didSaveItemDelegate?
    
    var date = Date()
    
    //MARK:- LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK:- Heler Methods

    private func setupUI(){
        self.title = "Add New Task"
        
        let cancelButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissController))
        self.navigationItem.leftBarButtonItem  = cancelButtonItem
        
        let saveButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTaskItem))
        self.navigationItem.rightBarButtonItem  = saveButtonItem
        
    }
   
    //MARK:- Selectors
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
                
                //Add to calender
                self.addEventToCalendar(title: title, description: descText, startDate: date, endDate: date.addingTimeInterval(2 * 60 * 60))
                
                if isSaved && self.delegate != nil {
                    self.delegate?.itemSaved()
                }
            }
        }
        
    }
    
    //MARK:- Calendere Event store
    
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()

        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    return
                }
                completion?(true, nil)
            } else {
                completion?(false, error as NSError?)
            }
        })
    }
    
}
