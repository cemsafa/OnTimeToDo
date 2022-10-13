//
//  Helper.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-12.
//

import Foundation
import SwiftUI

struct Helper {
    static func stringToDate(_ date: String) -> Date {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: date) ?? Date.now
    }
    
    static func formatDate(date: Date) -> some View {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return Text("Deadline: \(formatter.string(from: date))")
    }
}
