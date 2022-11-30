//
//  AddTask.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-11-30.
//

import SwiftUI

struct AddTask: View {
    let onSave: () -> ()
    var taskGroup: TaskGroup
    @ObservedObject var realmManager = RealmManager.shared
    @Binding public var isAddingNew: Bool
    @State private var name: String = ""
    @State private var definition: String = ""
    @State private var deadLine: Date = Date()
    @State private var status: Task.Status = .notStarted
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Name")
                        .bold()
                    
                    Divider()
                    
                    TextField("Name", text: $name)
                        .textInputAutocapitalization(.words)
                }
                
                HStack {
                    Text("Description")
                        .bold()
                    
                    Divider()
                    
                    TextEditor(text: $definition)
                        .textInputAutocapitalization(.sentences)
                }
                
                HStack {
                    Text("Deadline")
                        .bold()
                    
                    Divider()
                    
                    DatePicker("Deadline", selection: $deadLine, in: Date.now..., displayedComponents: .date)
                        .labelsHidden()
                }
            }
            .onAppear {
                UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
            }
            
            Spacer()
            
            Button("SAVE") {
                if name == "" || definition == "" {
                    showingAlert = true
                } else {
                    realmManager.createTask(taskGroupId: taskGroup.id, name: name, definition: definition, deadLine: deadLine, status: status)
                    isAddingNew.toggle()
                    onSave()
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Fill all fields"), dismissButton: .cancel())
            }
            .buttonStyle(.bordered)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(8)
            .padding()
        }
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask(onSave: {}, taskGroup: RealmManager.shared.taskGroups[0], isAddingNew: .constant(true))
            .environmentObject(RealmManager())
    }
}
