//
//  CoverPhoto.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-19.
//

import SwiftUI

struct CoverPhoto: View {
    var image: Image
    
    var gradient: LinearGradient {
        .linearGradient(Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]), startPoint: .bottom, endPoint: .center)
    }
    
    var body: some View {
        image
            .resizable()
            .frame(height: 250)
            .overlay(CameraOverlay())
    }
}

struct CameraOverlay: View {
    @State private var showingOptions = false
    
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
                        
                    } label: {
                        Text("Image Library")
                    }
                    Button {
                        
                    } label: {
                        Text("Camera")
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
        CoverPhoto(image: Image("cover"))
    }
}
