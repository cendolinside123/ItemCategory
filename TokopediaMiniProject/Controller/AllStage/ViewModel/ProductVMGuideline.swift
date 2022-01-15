//
//  ProductVMGuideline.swift
//  TokopediaMiniProject
//
//  Created by Mac on 14/01/22.
//

import Foundation

protocol ProductVMGuideline {
    func loadProduct(reloadTime: Int)
    func searchProduct(keyword: String)
    var productResult: (([Product]) -> Void)? { get set }
    var filterResult: (([Product]) -> Void)? { get set }
    var fetchError: ((Error) -> Void)? { get set }
    var result: [Product] { get set }
}
