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
    func fetchProduct(completion: @escaping (NetworkResult<Product>) -> Void) {
        
        
        guard let url = Bundle.main.path(forResource: "ProductData", ofType: "json") else {
//          completion(.failed("URL Not found"))
          return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe)
            let getJSON = JSON(data)
        } catch let error {
            completion(.failed(error))
        }
    }
    
    
}
