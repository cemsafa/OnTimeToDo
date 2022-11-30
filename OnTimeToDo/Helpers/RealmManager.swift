//
//  RealmManager.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-26.
//

import Foundation
import RealmSwift

final class RealmManager: ObservableObject {
    static let shared = RealmManager()
    private(set) var localRealm: Realm?
    @Published private(set) var profile: Profile = Profile()
    @Published private(set) var taskGroups: [TaskGroup] = []
    @Published private(set) var tasks: [Task] = []
    
    init() {
        openRealm()
        getProfile()
        getTaskGroups()
        getTasks()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error opening Realm: \(error)")
        }
    }
    
    func createUpdateProfile(name: String, phone: String, email: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    if let profileToUpdate = localRealm.objects(Profile.self).first {
                        profileToUpdate.name = name
                        profileToUpdate.phone = phone
                        profileToUpdate.email = email
                        localRealm.add(profileToUpdate, update: .modified)
                    } else {
                        let newProfile = Profile(value: [
                            "name": name,
                            "phone": phone,
                            "email": email
                        ])
                        localRealm.add(newProfile, update: .modified)
                    }
                }
            } catch {
                print("Error creating profile on Realm: \(error)")
            }
        }
    }
    
    func updateProfilePhoto(profilePhotoPath: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    if let profileToUpdate = localRealm.objects(Profile.self).first {
                        profileToUpdate.profilePhotoPath = profilePhotoPath
                        localRealm.add(profileToUpdate, update: .modified)
                    }
                }
            } catch {
                print("Error updating profile with profile photo on Realm: \(error)")
            }
        }
    }
    
    func updateProfileCover(coverPhotoPath: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    if let profileToUpdate = localRealm.objects(Profile.self).first {
                        profileToUpdate.coverPhotoPath = coverPhotoPath
                        localRealm.add(profileToUpdate, update: .modified)
                    }
                }
            } catch {
                print("Error updateing profile with cover photo on Realm: \(error)")
            }
        }
    }
    
    func getProfile() {
        if let localRealm = localRealm {
            profile = localRealm.objects(Profile.self).first ?? Profile()
        }
    }
    
    func createTaskGroup(name: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTaskGroup = TaskGroup(value: [
                        "name": name,
                        "tasks": []
                    ])
                    localRealm.add(newTaskGroup)
                    getTaskGroups()
                }
            } catch {
                print("Error creating TaskGroup on Realm: \(error)")
            }
        }
    }
    
    func getTaskGroups() {
        if let localRealm = localRealm {
            let allTaskGroups = localRealm.objects(TaskGroup.self)
            taskGroups = []
            allTaskGroups.forEach { taskGroup in
                taskGroups.append(taskGroup)
            }
        }
    }
    
    func deleteTaskGroup(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let taskGroupToDelete = localRealm.objects(TaskGroup.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskGroupToDelete.isEmpty else { return }
                try localRealm.write {
                    localRealm.delete(taskGroupToDelete)
                    getTaskGroups()
                }
            } catch {
                print("Error deleting TaskGroup on Realm: \(error)")
            }
        }
    }
    
    func createTask(taskGroupId: ObjectId, name: String, definition: String, deadLine: Date, status: Task.Status) {
        var newTask = Task()
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    newTask = Task(value: [
                        "name": name,
                        "definition": definition,
                        "deadLine": deadLine,
                        "status": status
                    ])
                    localRealm.add(newTask)
                    getTasks()
                }
                let taskGroupToUpdate = localRealm.objects(TaskGroup.self).filter(NSPredicate(format: "id == %@", taskGroupId))
                guard !taskGroupToUpdate.isEmpty else { return }
                try localRealm.write {
                    taskGroupToUpdate.first!.tasks.append(newTask)
                    getTaskGroups()
                }
            } catch {
                print("Error creating Task on Realm: \(error)")
            }
        }
    }
    
    func getTasks() {
        if let localRealm = localRealm {
            let allTasks = localRealm.objects(Task.self)
            tasks = []
            allTasks.forEach { task in
                tasks.append(task)
            }
        }
    }
    
    func deleteTask(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToDelete.isEmpty else { return }
                try localRealm.write {
                    localRealm.delete(taskToDelete)
                    getTasks()
                }
            } catch {
                print("Error deleting TaskGroup on Realm: \(error)")
            }
        }
    }
}
