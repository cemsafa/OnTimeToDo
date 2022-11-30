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
                NavigationLink {
                    AllTasksDetail()
                } label: {
                    AllTasksRow(task: task)
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
