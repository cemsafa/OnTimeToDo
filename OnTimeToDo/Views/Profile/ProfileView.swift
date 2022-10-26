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
    @ObservedObject var realmManager =  RealmManager.shared
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    
    init() {
        _name = State(initialValue: realmManager.profile.name)
        _phone = State(initialValue: realmManager.profile.phone)
        _email = State(initialValue: realmManager.profile.email)
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
                    let profile = realmManager.profile
                    if profile.name == "" && profile.phone == "" && profile.email == "" {
                        realmManager.createProfile(name: name, phone: phone, email: email)
                    } else {
                        realmManager.editProfile(id: profile.id, name: name, phone: phone, email: email)
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
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(RealmManager())
    }
}
