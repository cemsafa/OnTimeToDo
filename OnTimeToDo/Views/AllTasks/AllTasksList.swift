//
//  AllTasks.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-11.
//

import SwiftUI

struct AllTasksList: View {
    @ObservedObject var realmManager = RealmManager.shared
    @State private var selectedTask: Task?
    
    var body: some View {
        NavigationView {
            List(selection: $selectedTask) {
                ForEach(realmManager.tasks) { task in
                    if !task.isInvalidated {
                        NavigationLink {
                            AllTasksDetail(task: task)
                        } label: {
                            AllTasksRow(task: task)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                realmManager.deleteTask(id: task.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button {
                                realmManager.updateTask(id: task.id, status: .notStarted)
                            } label: {
                                Label("Not Started", systemImage: "multiply.circle.fill")
                            }
                            .tint(.red)
                            Button {
                                realmManager.updateTask(id: task.id, status: .inProgress)
                            } label: {
                                Label("In Progress", systemImage: "hourglass.circle.fill")
                            }
                            .tint(.yellow)
                            Button {
                                realmManager.updateTask(id: task.id, status: .completed)
                            } label: {
                                Label("Completed", systemImage: "checkmark.circle.fill")
                            }
                            .tint(.green)
                        }
                    }
                }
            }
            .navigationTitle("All Tasks")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AllTasksList_Previews: PreviewProvider {
    static var previews: some View {
        AllTasksList()
            .environmentObject(RealmManager())
    }
}
