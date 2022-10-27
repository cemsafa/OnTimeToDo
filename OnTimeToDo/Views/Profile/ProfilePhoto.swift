//
//  ProfilePhoto.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-19.
//

import SwiftUI

struct ProfilePhoto: View {
    @State private var showingOptions = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var isImagePickerShowing = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
            } else {
                Image(uiImage: UIImage(imageLiteralResourceName: "profile"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
            }
            Button {
                showingOptions = true
            } label: {
                Image(systemName: "camera.fill")
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                    .background(Color.black)
                    .clipShape(Circle())
            }
            .confirmationDialog("Add profile photo", isPresented: $showingOptions, titleVisibility: .visible) {
                Button {
                    sourceType = .photoLibrary
                    isImagePickerShowing.toggle()
                } label: {
                    Text("Image Library")
                }
                Button {
                    sourceType = .camera
                    isImagePickerShowing.toggle()
                } label: {
                    Text("Camera")
                }
            }
            .sheet(isPresented: $isImagePickerShowing) {
                ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
            }
        }
    }
}

struct ProfilePhoto_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhoto()
    }
}
