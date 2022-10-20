//
//  Profile.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-19.
//

import Foundation
import RealmSwift

class Profile: Object, ObjectKeyIdentifiable {
    @Persisted var name = ""
    @Persisted var phone = ""
    @Persisted var email = ""
}
