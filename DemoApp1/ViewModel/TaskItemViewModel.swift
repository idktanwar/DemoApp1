//
//  TaskItemViewModel.swift
//  DemoApp1
//
//  Created by Dinesh Tanwar on 23/06/21.
//

import Foundation

class TaskItemViewModel {
    
    private var items = [TaskItem]()
    var todays = [TaskItem]()
    var tommTasks = [TaskItem]()
    var laterTask = [TaskItem]()

    func fetchTaskData(completion: @escaping () -> ()) {
        todays.removeAll()
        tommTasks.removeAll()
        laterTask.removeAll()
        
        let taskData = TaskData.fetchTaskItemsLists()
        
        if let taskItems = taskData {
            for item in taskItems {
                
                guard let title = item.title else {continue}
                guard let desc =  item.desc else {continue}
                guard let date  = item.date else {continue}
                
                let now = Date()
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .none
                dateFormatter.dateStyle = .short
                let date1String = dateFormatter.string(from: date)
                let currentDateString = dateFormatter.string(from: now)
                
                let taskItem = TaskItem(title: title, description: desc, date: date, iscompleted: item.completed)
                let tommDate = (Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
                
                if date.isBetween(date: now as Date, andDate: tommDate as Date) {
                    self.tommTasks.append(taskItem)
                }
                else if date1String == currentDateString {
                    self.todays.append(taskItem)
                }
                else {
                    self.laterTask.append(taskItem)
                }
            }
        }
        completion()
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return items.count
    }
    
    func cellForRowAt (indexPath: IndexPath) -> TaskItem {
        let data: TaskItem = items[indexPath.row]
        return data
    }
    
}

extension Date {
    func isBetween(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self as Date).rawValue * self.compare(date2 as Date).rawValue >= 0
    }
}
