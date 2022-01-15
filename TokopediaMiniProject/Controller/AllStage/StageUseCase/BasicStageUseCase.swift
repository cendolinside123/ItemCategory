//
//  BasicStageUseCase.swift
//  TokopediaMiniProject
//
//  Created by Mac on 14/01/22.
//

import Foundation
import SwiftyJSON
import Alamofire

struct BasicStageUseCase {
    
}

extension BasicStageUseCase: StageNetworkProvider {
    func fetchProduct(completion: @escaping (NetworkResult<[Product]>) -> Void) {
        
        
        guard let url = Bundle.main.path(forResource: "data", ofType: "json") else {
            completion(.failed(NetworkError.loadFailed))
          return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe)
            let getJSON = JSON(data)
            
            var getListProduct: [Product] = []
            
            for product in getJSON["data"]["categoryAllList"]["categories"].arrayValue {
                getListProduct.append(Product(json: product))
            }
            completion(.success(getListProduct))
            
        } catch let error {
            completion(.failed(error))
        }
    }
    
    
}
