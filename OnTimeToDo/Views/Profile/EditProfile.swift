//
//  EditProfile.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-27.
//

import SwiftUI
import iPhoneNumberField

struct EditProfile: View {
    @ObservedObject var realmManager =  RealmManager.shared
    @Binding public var isEditing: Bool
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    
    var body: some View {
        VStack {
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
            Button("SAVE") {
                realmManager.editProfile(id: realmManager.profile.id, name: name, phone: phone, email: email)
                isEditing.toggle()
            }
            .buttonStyle(.bordered)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(8)
            .padding()
        }
    }
}

//struct EditProfile_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfile()
//    }
//}
