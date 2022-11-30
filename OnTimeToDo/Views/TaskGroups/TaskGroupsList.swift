//
//  TaskGroups.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-11.
//

import SwiftUI

struct TaskGroupsList: View {
    @ObservedObject var realmManager = RealmManager.shared
    @State private var selectedTaskGroup: TaskGroup?
    @State private var isAddingNew = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            List(selection: $selectedTaskGroup) {
                ForEach(realmManager.taskGroups) { taskGroup in
                    NavigationLink {
                        TaskGroupsDetail(taskGroup: taskGroup)
                    } label: {
                        TaskGroupsRow(taskGroup: taskGroup)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            if taskGroup.tasks.count != 0 {
                                showingAlert = true
                            } else {
                                realmManager.deleteTaskGroup(id: taskGroup.id)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Task Group Has Tasks"), dismissButton: .cancel())
                        }
                    }
                }
            }
            .navigationTitle("Task Groups")
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
                    AddTaskGroup(onSave: realmManager.getTaskGroups, isAddingNew: $isAddingNew)
                        .navigationBarTitle("Add Task Group")
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
}

struct TaskGroupsList_Previews: PreviewProvider {
    static var previews: some View {
        TaskGroupsList()
            .environmentObject(RealmManager())
    }
}
