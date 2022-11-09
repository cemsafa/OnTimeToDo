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
}
