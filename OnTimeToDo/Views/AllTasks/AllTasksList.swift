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
                    NavigationLink {
                        AllTasksDetail()
                    } label: {
                        AllTasksRow(task: task)
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
