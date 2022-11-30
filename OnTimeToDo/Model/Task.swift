//
//  Task.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-11.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var definition: String
    @Persisted var deadLine: Date
    @Persisted var status: Status
    
    enum Status: String, PersistableEnum {
        case notStarted = "Not Started"
        case inProgress = "In Progress"
        case completed = "Completed"
    }
}
