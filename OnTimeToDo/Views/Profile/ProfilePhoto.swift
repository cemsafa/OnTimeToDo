//
//  ProfilePhoto.swift
//  OnTimeToDo
//
//  Created by Cem Safa on 2022-10-19.
//

import SwiftUI

struct ProfilePhoto: View {
    var image: Image
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            image
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
            .shadow(radius: 7)
            Image(systemName: "camera.fill")
                .foregroundColor(.white)
                .frame(width: 25, height: 25)
                .background(Color.black)
                .clipShape(Circle())
        }
    }
}

struct ProfilePhoto_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhoto(image: Image("profile"))
    }
}
