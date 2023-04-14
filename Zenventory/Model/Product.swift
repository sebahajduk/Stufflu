//
//  Product.swift
//  Zenventory
//
//  Created by Sebastian Hajduk on 23/03/2023.
//

import SwiftUI

struct Product: Hashable {

    // MARK: - Product
    var name: String
    var image: UIImage?
    var alert: String?
    var guarantee: Int? //Months
    var description: String?
    var favorite: Bool?
    var importance: Int
    /// Care time is about to inform user about something important to make product life longer
    /// for example protect the leather of shoes.
    var careName: String?
    var careInterval: Int? //Days

    // MARK: - Usage
    var lastUsed: Date
}
