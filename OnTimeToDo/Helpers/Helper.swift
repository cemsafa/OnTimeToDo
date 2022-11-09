//
//  Helper.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-12.
//

import Foundation
import SwiftUI

struct Helper {
    enum PhotoType {
        case cover
        case profile
    }
    
    static func stringToDate(_ date: String) -> Date {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: date) ?? Date.now
    }
    
    static func formatDate(date: Date) -> some View {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return Text("Deadline: \(formatter.string(from: date))")
    }
    
    static func loadImageFromPath(_ path: String) -> UIImage? {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(path)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image: \(error)")
        }
        return nil
    }
    
    static func getPathFromImage(_ image: UIImage, photoType: PhotoType) -> String? {
        var filename: String
        switch photoType {
        case .cover:
            filename = String(Int(Date().timeIntervalSince1970)) + "_cover.png"
        case .profile:
            filename = String(Int(Date().timeIntervalSince1970)) + "_profile.png"
        }
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(filename)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try? imageData.write(to: fileURL, options: .atomic)
            return filename
        }
        return nil
    }
}
