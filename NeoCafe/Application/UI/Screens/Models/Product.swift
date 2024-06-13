//
//  Product.swift
//  NeoCafe
//
//  Created by Pokerface on 05.06.2024.
//

import Foundation

struct Product: Codable {
    var id: Int
    var title: String
    var category: Int
    var imageURL: String
    var quantity: Int
    var price: Double
}
