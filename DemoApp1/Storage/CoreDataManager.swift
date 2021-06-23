//
//  CoreDataManager.swift
//  DemoApp1
//
//  Created by Dinesh Tanwar on 22/06/21.
//

import Foundation
import CoreData

class CoreDataManager {

    static let sharedInstance = CoreDataManager()

    let model: String = "DemoApp1"
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let messageKitBundle = Bundle(for: CoreDataManager.self)
        let modelURL = messageKitBundle.url(forResource: self.model, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)
        
        let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { (storeDescription, error) in
            if let err = error{
                fatalError("❌ Loading of store failed:\(err)")
            }
        }
        
        return container
    }()
    
    //Add New Task Item
    func addNewTaskItem(taskItem: TaskItem) -> Bool {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return TaskData.addNewItem(task: taskItem, context: context)
    }
    
}
