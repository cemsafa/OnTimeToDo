//
//  Profile.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-11.
//

import SwiftUI
import iPhoneNumberField
import RealmSwift

struct ProfileView: View {
    @ObservedRealmObject var profile: Profile = Profile()
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    
    init() {
        _name = State(initialValue: profile.name)
        _phone = State(initialValue: profile.phone)
        _email = State(initialValue: profile.email)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    CoverPhoto(image: Image("cover"))
                    ProfilePhoto(image: Image("profile"))
                }
                
                Spacer()
                
                List {
                    TextField("Name", text: $name)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        Text("Phone")
                            .bold()
                        Divider()
                        iPhoneNumberField("Phone", text: $phone)
                    }
                    
                    HStack {
                        Text("Email")
                            .bold()
                        Divider()
                        TextField("Email", text: $email)
                    }
                }
                .onAppear {
                    UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
                }
                
                Spacer()
                
                Button("SAVE") {
                    if profile.name != "" && profile.phone != "" && profile.email != "" {
                        save()
                    } else {
                        update()
                    }
                }
                .buttonStyle(.bordered)
                .foregroundColor(.white)
                .background(Color.accentColor)
                .cornerRadius(8)
                .padding()
                Spacer()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func save() {
        let realm = try! Realm()
        try! realm.write {
            profile.name = name
            profile.phone = phone
            profile.email = email
        }
    }
    
    private func update() {
        let realm = try! Realm()
        guard let object = realm.objects(Profile.self).first else { return }
        try! realm.write {
            object.name = name
            object.phone = phone
            object.email = email
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
