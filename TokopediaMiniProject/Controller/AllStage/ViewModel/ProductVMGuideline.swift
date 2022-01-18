//
//  ProductVMGuideline.swift
//  TokopediaMiniProject
//
//  Created by Mac on 14/01/22.
//

import Foundation

protocol ProductVMGuideline {
    func loadProduct(reloadTime: Int)
    func searchProduct(keyword: String, type: VCType)
    func expandProduct(child: [Product])
    func hideAllProduct(id: String)
    func hideSpesificProduct(child: [Product])
    func selectExpandProduct(product: Product, type: VCType)
    var productResult: (([Product]) -> Void)? { get set }
    var filterResult: (([Product]) -> Void)? { get set }
    var toggleResult: (([Int], Bool) -> Void)? { get set }
    var sendaProduct: ((Product) -> Void)? { get set }
    var fetchError: ((Error) -> Void)? { get set }
    var result: [Product] { get set }
}
