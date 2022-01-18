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
    let root: String
}

extension Product {
    init(json: JSON, level: Int = 0, root: String = "") {
        id = json["id"].stringValue
        name = json["name"].stringValue
        identifier = json["identifier"].stringValue
        url = json["url"].stringValue
        iconImageUrl = json["iconImageUrl"].stringValue
        parentName = json["parentName"].stringValue
        applinks = json["applinks"].stringValue
        iconBannerURL = json["iconBannerURL"].stringValue
        self.level = level
        self.root = root
        var childProduct = [Product]()
        for product in json["child"].arrayValue {
            childProduct.append(Product(json: product, level: level + 1, root: self.root == "" ? id : self.root))
        }
        child = childProduct
        
    }
    
    init(aJson: JSON, level: Int = 0, root: String = "") {
        id = aJson["id"].stringValue
        name = aJson["name"].stringValue
        identifier = aJson["identifier"].stringValue
        url = aJson["url"].stringValue
        iconImageUrl = aJson["icon_image_url"].stringValue
        parentName = aJson["parentName"].stringValue
        applinks = aJson["applinks"].stringValue
        iconBannerURL = aJson["icon_banner"].stringValue
        self.level = level
        self.root = root
        var childProduct = [Product]()
        for product in aJson["child"].arrayValue {
            childProduct.append(Product(json: product, level: level + 1, root: self.root == "" ? id : self.root))
        }
        child = childProduct
        
    }
    
    // MARK: please don't use this init for prod, I use it for setup Mockup data
    init(id: String, name: String, identifier: String, url: String, iconImageUrl: String,
         parentName: String, applinks: String, iconBannerURL: String, child: [Product], level: Int) {
        self.id = id
        self.name = name
        self.identifier = identifier
        self.url = url
        self.iconImageUrl = iconImageUrl
        self.parentName = parentName
        self.applinks = applinks
        self.iconBannerURL = iconBannerURL
        self.child = child
        self.root = id
        self.level = level
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
