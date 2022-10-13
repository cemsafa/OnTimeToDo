//
//  Task.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-11.
//

import Foundation

struct Task: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var deadLine: String
    
    var status: Status
    enum Status: String, CaseIterable ,Codable {
        case notStarted = "Not Started"
        case inProgress = "In Progress"
        case completed = "Completed"
    }
}
