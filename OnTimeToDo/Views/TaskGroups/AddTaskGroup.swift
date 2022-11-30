//
//  AddTaskGroup.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-11-30.
//

import SwiftUI

struct AddTaskGroup: View {
    let onSave: () -> ()
    @ObservedObject var realmManager = RealmManager.shared
    @Binding public var isAddingNew: Bool
    @State private var name: String = ""
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
            }
            .onAppear {
                UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
            }
            
            Spacer()
            
            Button("SAVE") {
                if name == "" {
                    showingAlert = true
                } else {
                    realmManager.createTaskGroup(name: name)
                    isAddingNew.toggle()
                    onSave()
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Name is empty"), dismissButton: .cancel())
            }
            .buttonStyle(.bordered)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(8)
            .padding()
        }
    }
}

struct AddTaskGroup_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskGroup(onSave: {}, isAddingNew: .constant(true))
    }
}
