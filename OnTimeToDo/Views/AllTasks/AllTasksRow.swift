//
//  AllTasksRow.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-11.
//

import SwiftUI

struct AllTasksRow: View {
    var task: Task
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.name)
                    .bold()
                Helper.formatDate(date: Helper.stringToDate(task.deadLine))
            }
            
            Spacer()
            
            switch task.status {
            case .notStarted:
                Image(systemName: "multiply.circle.fill")
                    .foregroundColor(.red)
            case .inProgress:
                Image(systemName: "hourglass.circle.fill")
                    .foregroundColor(.yellow)
            case .completed:
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
        .padding(.vertical, 4)
    }
}

struct AllTasksRow_Previews: PreviewProvider {
    static var tasks = RealmManager().tasks
    
    static var previews: some View {
        AllTasksRow(task: tasks[0])
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
