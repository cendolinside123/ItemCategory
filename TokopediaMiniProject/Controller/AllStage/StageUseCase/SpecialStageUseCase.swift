//
//  SpecialStageUseCase.swift
//  TokopediaMiniProject
//
//  Created by Mac on 14/01/22.
//

import Foundation
import SwiftyJSON
import Alamofire

struct SpecialStageUseCase {
    
}

extension SpecialStageUseCase: StageNetworkProvider {
    
    
    func fetchProduct(completion: @escaping (NetworkResult<[Product]>) -> Void) {
        DispatchQueue.global().async {
            AF.request(Constant.APIProduct, method: .get, parameters: Optional<String>.none, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON(completionHandler:  { response in
                switch response.result {
                case .success(let data):
                    let getJSON = JSON(data)
                    
                    var getListProduct: [Product] = []
                    
                    for product in getJSON["categoryAllList"]["categories"].arrayValue {
                        getListProduct.append(Product(json: product))
                    }
                    DispatchQueue.main.async {
                        completion(.success(getListProduct))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failed(error))
                    }
                }
            })
        }
    }
    
    
}
