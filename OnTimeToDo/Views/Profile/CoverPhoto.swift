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
    var gradient: LinearGradient {
        .linearGradient(Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]), startPoint: .bottom, endPoint: .center)
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            gradient
            VStack(alignment: .leading) {
                Image(systemName: "camera.fill")
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
