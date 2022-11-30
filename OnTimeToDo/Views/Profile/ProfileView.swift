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
    @ObservedObject var realmManager = RealmManager.shared
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var isEditing = false
    
    init() {
        _name = State(initialValue: realmManager.profile.name)
        _phone = State(initialValue: realmManager.profile.phone)
        _email = State(initialValue: realmManager.profile.email)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    CoverPhoto()
                    ProfilePhoto()
                }
                
                Spacer()
                
                Text(realmManager.profile.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                List {
                    HStack {
                        Text("Phone")
                            .bold()
                        Divider()
                        Text(realmManager.profile.phone)
                    }
                    
                    HStack {
                        Text("Email")
                            .bold()
                        Divider()
                        Text(realmManager.profile.email)
                    }
                }
                .onAppear {
                    UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isEditing = true
                    } label: {
                        Text("Edit")
                    }
                }
            }
            .sheet(isPresented: $isEditing) {
                NavigationView {
                    EditProfile(onSave: realmManager.getProfile, isEditing: $isEditing, name: $name, phone: $phone, email: $email)
                        .navigationBarItems(trailing: Button(action: {
                            self.isEditing.toggle()
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(.red)
                        }))
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(RealmManager())
    }
}
