//
//  ContentView.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-11.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State private var selection: Tab = .allTasks
    @StateObject var realmManager = RealmManager()
    
    enum Tab {
        case allTasks
        case taskGroups
        case profile
    }
    
    var body: some View {
        TabView(selection: $selection) {
            AllTasksList()
                .tabItem {
                    Label("All Tasks", systemImage: "list.dash")
                }
                .tag(Tab.allTasks)
                .environmentObject(realmManager)
            
            TaskGroupsList()
                .tabItem {
                    Label("Task Groups", systemImage: "folder.fill")
                }
                .tag(Tab.taskGroups)
                .environmentObject(realmManager)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                .tag(Tab.profile)
                .environmentObject(realmManager)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RealmManager())
    }
}
