//
//  AllTasksDetail.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-11.
//

import SwiftUI

struct AllTasksDetail: View {
    var task: Task
    
    var body: some View {
        List {
            HStack {
                Text("Name")
                    .bold()
                
                Divider()
                
                Text(task.name)
            }
            
            HStack {
                Text("Description")
                    .bold()
                
                Divider()
                
                Text(task.definition)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            HStack {
                Text("Deadline")
                    .bold()
                
                Divider()
                
                Text(Helper.dateToString(task.deadLine))
            }
            
            HStack {
                Text("Status")
                    .bold()
                
                Divider()
                
                Text(task.status.rawValue)
            }
        }
        .onAppear {
            UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
        }
        .navigationTitle(task.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AllTasksDetail_Previews: PreviewProvider {
    static var previews: some View {
        AllTasksDetail(task: RealmManager.shared.tasks[0])
    }
}
