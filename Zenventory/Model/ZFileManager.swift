//
//  ZFileManager.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 24/04/2023.
//

import SwiftUI

class ZFileManager {

    static let instance = ZFileManager()

    func saveImage(productImage: UIImage, name: String) {
        guard
            let productImgData = productImage.jpegData(compressionQuality: 1.0),
            let productPhotoPath = getPathForImage(name: name)
        else {
            print("Error getting Data")
            return
        }

        do {
            try productImgData.write(to: productPhotoPath)
            print("Successfully saved photos")
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func getImage(name: String) -> UIImage? {
        guard
            let productPhotoPath = getPathForImage(name: name)?.path else {
            print("Error getting path")
            return nil
        }

        return UIImage(contentsOfFile: productPhotoPath)
    }

    func getPathForImage(name: String) -> URL? {
        guard
            let productPhotoPath = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent("\(name).jpg")
        else {
            print("Error getting path.")
            return nil
        }

        return productPhotoPath
    }

    func deleteImage(name: String) {
        guard
            let productPhotoPath = getPathForImage(name: name) else {
            print("Error getting path")
            return
        }

        do {
            try FileManager.default.removeItem(at: productPhotoPath)
        } catch {
            print("Error deleting image.")
        }
    }

}
