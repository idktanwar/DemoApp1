//
//  TaskData+CoreDataProperties.swift
//  DemoApp1
//
//  Created by Dinesh Tanwar on 22/06/21.
//
//

import Foundation
import CoreData


extension TaskData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskData> {
        return NSFetchRequest<TaskData>(entityName: "TaskData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var completed: Bool

}

extension TaskData : Identifiable {

}
