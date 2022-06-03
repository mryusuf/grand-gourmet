//
//  GourmetDetailModel.swift
//  Grand Gourmet
//
//  Created by Indra Permana on 03/06/22.
//

import Foundation

struct GourmetDetail: Codable {
    let id: String
    let price, displayPrice: Int
    let isDiscount: Bool
    let discountPercent: Int
    let imageURL: String
    let name, gourmetDetailDescription: String
    let tags: [String]
    let variants: [Variant]
    let addons: [Addon]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case price
        case displayPrice = "display_price"
        case isDiscount = "is_discount"
        case discountPercent = "discount_percent"
        case imageURL = "image_url"
        case name
        case gourmetDetailDescription = "description"
        case tags, variants, addons
    }
}

struct Addon: Codable {
    let addonCategoryID, addonCateogryName: String
    let addonItems: [AddonItem]

    enum CodingKeys: String, CodingKey {
        case addonCategoryID = "addon_category_id"
        case addonCateogryName = "addon_cateogry_name"
        case addonItems = "addon_items"
    }
}

struct AddonItem: Codable {
    let id, name: String
    let additionalPrice: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case additionalPrice = "additional_price"
    }
}

struct Variant: Codable {
    let id, name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}
