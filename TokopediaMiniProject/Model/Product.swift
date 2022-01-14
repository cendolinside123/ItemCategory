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
}

extension Product {
    init(json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        identifier = json["identifier"].stringValue
        url = json["url"].stringValue
        iconImageUrl = json["iconImageUrl"].stringValue
        parentName = json["parentName"].stringValue
        applinks = json["applinks"].stringValue
        iconBannerURL = json["iconBannerURL"].stringValue
        
        var childProduct = [Product]()
        for product in json["child"].arrayValue {
            childProduct.append(Product(json: product))
        }
        child = childProduct
        
    }
}
