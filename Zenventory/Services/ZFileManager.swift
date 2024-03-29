//
//  ZFileManager.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 24/04/2023.
//

import SwiftUI

struct ZFileManager {

    static func saveImage(
        productImage: UIImage,
        name: String
    ) throws {
        guard
            let productImgData: Data = productImage.jpegData(compressionQuality: 1.0),
            let productPhotoPath: URL = try getPathForImage(name: name)
        else {
            throw ZFileManagerError.gettingData
        }

        do {
            try productImgData.write(to: productPhotoPath)
        } catch let error {
            throw error
        }
    }

    static func getImage(
        name: String
    ) throws -> UIImage? {
        guard
            let productPhotoPath: String = try getPathForImage(name: name)?.path else {
            throw ZFileManagerError.gettingPath
        }

        return UIImage(contentsOfFile: productPhotoPath)
    }

    static func getPathForImage(
        name: String
    ) throws -> URL? {
        guard
            let productPhotoPath: URL = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent("\(name).jpg")
        else {
            throw ZFileManagerError.gettingPath
        }

        return productPhotoPath
    }

    static func deleteImage(
        name: String
    ) throws {
        guard
            let productPhotoPath: URL = try getPathForImage(name: name) else {
            throw ZFileManagerError.gettingPath
        }

        do {
            try FileManager.default.removeItem(at: productPhotoPath)
        } catch {
            throw error
        }
    }

}
