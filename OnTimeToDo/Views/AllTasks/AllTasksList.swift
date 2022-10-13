//
//  AllTasks.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-11.
//

import SwiftUI

struct AllTasksList: View {
    @EnvironmentObject var dataLoad: DataLoad
    @State private var selectedTask: Task?
    var mockData: [Task] = DataLoad().tasks
    
    var body: some View {
        NavigationView {
            List(selection: $selectedTask) {
                ForEach(mockData) { task in
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
            .environmentObject(DataLoad())
    }
}
