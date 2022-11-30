//
//  TaskGroup.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-11-29.
//

import Foundation
import RealmSwift

class TaskGroup: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var tasks: List<Task>
}
