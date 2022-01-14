//
//  StageNetworkProvider.swift
//  TokopediaMiniProject
//
//  Created by Mac on 14/01/22.
//

import Foundation


protocol StageNetworkProvider {
    func fetchProduct(completion: @escaping (NetworkResult<Product>) -> Void)
}
