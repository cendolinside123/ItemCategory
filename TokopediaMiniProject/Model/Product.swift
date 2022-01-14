//
//  Product.swift
//  TokopediaMiniProject
//
//  Created by Mac on 14/01/22.
//

import Foundation

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
