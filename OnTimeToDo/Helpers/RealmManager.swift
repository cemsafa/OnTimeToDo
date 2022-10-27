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
    
    init() {
        openRealm()
        getProfile()
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
    
    func createProfile(name: String, phone: String, email: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newProfile = Profile(value: [
                        "name": name,
                        "phone": phone,
                        "email": email
                    ])
                    localRealm.add(newProfile)
                }
            } catch {
                print("Error creating profile on Realm: \(error)")
            }
        }
    }
    
    func editProfile(id: ObjectId, name: String?, phone: String?, email: String?) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let profileToUpdate = localRealm.objects(Profile.self).filter(NSPredicate(format: "id == %@", id))
                    guard !profileToUpdate.isEmpty else { return }
                    try localRealm.write {
                        profileToUpdate.first!.name = name ?? profileToUpdate.first!.name
                        profileToUpdate.first!.phone = phone ?? profileToUpdate.first!.phone
                        profileToUpdate.first!.email = email ?? profileToUpdate.first!.email
                    }
                }
            } catch {
                print("Error editing profile on Realm: \(error)")
            }
        }
    }
    
    func getProfile() {
        if let localRealm = localRealm {
            profile = localRealm.objects(Profile.self).first ?? Profile()
        }
    }
}
