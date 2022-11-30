//
//  CoverPhoto.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-19.
//

import SwiftUI

struct CoverPhoto: View {
    @ObservedObject var realmManager = RealmManager.shared
    @State private var selectedImage: UIImage?
    
    var gradient: LinearGradient {
        .linearGradient(Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]), startPoint: .bottom, endPoint: .center)
    }
    
    var body: some View {
        if selectedImage != nil {
            Image(uiImage: selectedImage!)
                .resizable()
                .frame(height: 250)
                .overlay(CameraOverlay(selectedImage: $selectedImage))
        } else {
            Image(uiImage: Helper.loadImageFromPath(realmManager.profile.coverPhotoPath) ?? UIImage(imageLiteralResourceName: "cover"))
                .resizable()
                .frame(height: 250)
                .overlay(CameraOverlay(selectedImage: $selectedImage))
        }
    }
}

struct CameraOverlay: View {
    @ObservedObject var realmManager = RealmManager.shared
    @State private var showingOptions = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var isImagePickerShowing = false
    @Binding public var selectedImage: UIImage?
    
    var gradient: LinearGradient {
        .linearGradient(Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]), startPoint: .bottom, endPoint: .center)
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            gradient
            VStack(alignment: .leading) {
                Button {
                    showingOptions = true
                } label: {
                    Image(systemName: "camera.fill")
                }
                .confirmationDialog("Add cover photo", isPresented: $showingOptions, titleVisibility: .visible) {
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
                .onChange(of: selectedImage) { image in
                    if let image = image {
                        if let path = Helper.getPathFromImage(image, photoType: .cover) {
                            realmManager.updateProfileCover(coverPhotoPath: path)
                        }
                    }
                }
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct CoverPhoto_Previews: PreviewProvider {
    static var previews: some View {
        CoverPhoto()
    }
}
