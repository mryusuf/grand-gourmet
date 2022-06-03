//
//  HomeModel.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 02/06/22.
//

import Foundation

struct HomeModel: Codable {
    let categories: [GourmetCategory]
    let list: [GourmetList]
}

struct GourmetCategory: Codable {
    let id, name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}

struct GourmetList: Codable {
    let categoryID: String
    let items: [GourmetItem]

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case items
    }
}

struct GourmetItem: Codable {
    let id: String
    let price, displayPrice: Double
    let isDiscount: Bool
    let discountPercent: Int
    let imageURL: String
    let name, itemDescription: String
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case price
        case displayPrice = "display_price"
        case isDiscount = "is_discount"
        case discountPercent = "discount_percent"
        case imageURL = "image_url"
        case name
        case itemDescription = "description"
        case tags
    }
}
