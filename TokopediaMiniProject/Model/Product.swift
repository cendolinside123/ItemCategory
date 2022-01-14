//
//  Product.swift
//  TokopediaMiniProject
//
//  Created by Mac on 14/01/22.
//

import Foundation
import SwiftyJSON

struct Product {
    let id: String
    let name: String
    let identifier: String
    let url: String
    let iconImageUrl: String
    let parentName: String
    let applinks: String
    let iconBannerURL: String
    let child: [Product]
    let level: Int
}

extension Product {
    init(json: JSON, level: Int = 0) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        identifier = json["identifier"].stringValue
        url = json["url"].stringValue
        iconImageUrl = json["iconImageUrl"].stringValue
        parentName = json["parentName"].stringValue
        applinks = json["applinks"].stringValue
        iconBannerURL = json["iconBannerURL"].stringValue
        self.level = level
        var childProduct = [Product]()
        for product in json["child"].arrayValue {
            childProduct.append(Product(json: product, level: level + 1))
        }
        child = childProduct
        
    }
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.identifier == rhs.identifier &&
        lhs.url == rhs.url &&
        lhs.iconImageUrl == rhs.iconImageUrl &&
        lhs.parentName == rhs.parentName &&
        lhs.applinks == rhs.applinks &&
        lhs.iconBannerURL == rhs.iconBannerURL &&
        lhs.child == rhs.child
    }
}
