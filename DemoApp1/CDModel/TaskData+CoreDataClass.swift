//
//  TaskData+CoreDataClass.swift
//  DemoApp1
//
//  Created by Dinesh Tanwar on 22/06/21.
//
//

import Foundation
import CoreData

@objc(TaskData)
public class TaskData: NSManagedObject {

    @nonobjc public class func getFetchRequest() -> NSFetchRequest<TaskData> {
        return NSFetchRequest<TaskData>(entityName: "TaskData")
    }
    
    //add the newly movie to local DB
    class func addNewItem(task: TaskItem, context: NSManagedObjectContext) -> Bool {
        
        guard let newTask = NSEntityDescription.insertNewObject(forEntityName: "TaskData", into: context) as? TaskData else {
            return false
        }
        
        newTask.completed = task.iscompleted
        newTask.date = task.date
        newTask.title = task.title
        newTask.desc = task.description
        
        do {
            try context.save()
            print("✅ Task Item saved succesfuly")
            return true
            
        } catch let error {
            print("❌ Failed to add task item: \(error.localizedDescription)")
            return false
        }
        
    }

    //get the list of items
    class func fetchTaskItemsLists() -> [TaskData]? {
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext

        let fetchRequest = TaskData.getFetchRequest()
        fetchRequest.predicate = NSPredicate(format: "completed == %@", NSNumber(value: false))
        do {
            let taskitems = try context.fetch(fetchRequest)
            return taskitems
            
        } catch let fetchErr {
            print("❌ Failed to fetch:",fetchErr)
            return nil
        }
    }
    
}

