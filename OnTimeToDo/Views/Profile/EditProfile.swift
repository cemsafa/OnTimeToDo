//
//  EditProfile.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-27.
//

import SwiftUI
import iPhoneNumberField

struct EditProfile: View {
    let onSave: () -> ()
    @ObservedObject var realmManager =  RealmManager.shared
    @Binding public var isEditing: Bool
    
    @Binding public var name: String
    @Binding public var phone: String
    @Binding public var email: String
    
    var body: some View {
        VStack {
            List {
                TextField("Name", text: $name)
                    .font(.title)
                    .textInputAutocapitalization(.words)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Text("Phone")
                        .bold()
                    Divider()
                    iPhoneNumberField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                }
                
                HStack {
                    Text("Email")
                        .bold()
                    Divider()
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                }
            }
            .onAppear {
                UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
            }
            Button("SAVE") {
                realmManager.createUpdateProfile(name: name, phone: phone, email: email)
                isEditing.toggle()
                onSave()
            }
            .buttonStyle(.bordered)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(8)
            .padding()
        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile(onSave: {}, isEditing: .constant(true), name: .constant("John Doe"), phone: .constant("(234) 567 8901"), email: .constant("johndoe@mail.com"))
    }
}
