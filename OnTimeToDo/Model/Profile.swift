//
//  Profile.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-19.
//

import Foundation
import RealmSwift

class Profile: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var phone: String
    @Persisted var email: String
    @Persisted var profilePhotoPath: String
    @Persisted var coverPhotoPath: String
}
