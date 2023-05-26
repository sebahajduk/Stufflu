//
//  FullscreenPhotoView.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 26/05/2023.
//

import SwiftUI

struct FullscreenPhotoView: View {

    @State var image: UIImage?

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .shadow(radius: 10)
                .toolbarRole(.editor)
                .toolbar {
                    Button("Edit") { }
                }

        } else {
            ZStack {
                Image(systemName: "camera.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.gray.opacity(0.05))
                    .padding()

                Button("Add invoice") { }
                    .buttonStyle(StandardButton())
            }
        }
    }
}

struct FullscreenPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        FullscreenPhotoView()
    }
}
