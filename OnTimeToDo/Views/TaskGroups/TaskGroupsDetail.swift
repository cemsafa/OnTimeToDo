//
//  TaskGroupsDetail.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-11-29.
//

import SwiftUI

struct TaskGroupsDetail: View {
    @ObservedObject var realmManager = RealmManager.shared
    @State private var selectedTask: Task?
    @State private var isAddingNew = false
    
    var taskGroup: TaskGroup
    
    var body: some View {
        List(selection: $selectedTask) {
            ForEach(taskGroup.tasks) { task in
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
        .navigationTitle(taskGroup.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isAddingNew = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddingNew) {
            NavigationView {
                AddTask(onSave: realmManager.getTaskGroups, taskGroup: taskGroup, isAddingNew: $isAddingNew)
                    .navigationBarTitle("Add Task")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: Button(action: {
                        self.isAddingNew.toggle()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }))
            }
        }
    }
}

struct TaskGroupsDetail_Previews: PreviewProvider {
    static var previews: some View {
        TaskGroupsDetail(taskGroup: RealmManager.shared.taskGroups[0])
            .environmentObject(RealmManager())
    }
}
