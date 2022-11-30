//
//  TaskGroupsRow.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-11-29.
//

import SwiftUI

struct TaskGroupsRow: View {
    var taskGroup: TaskGroup
    
    var body: some View {
        HStack {
            Text(taskGroup.name)
                .bold()
                .badge(taskGroup.tasks.count)
        }
    }
}

struct TaskGroupsRow_Previews: PreviewProvider {
    static var taskGroups = RealmManager().taskGroups
    
    static var previews: some View {
        TaskGroupsRow(taskGroup: taskGroups[0])
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
