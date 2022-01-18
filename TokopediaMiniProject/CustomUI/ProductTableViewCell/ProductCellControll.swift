//
//  ProductCellControll.swift
//  TokopediaMiniProject
//
//  Created by Mac on 18/01/22.
//

import Foundation
import UIKit

class ProductCellControll {
    init() {
    }
    
}
extension ProductCellControll: ProductTableHelper {
    func doValidation(product: Product, childInfo: UIView, spaceLvOne: UIView, spaceLvTwo: UIView) {
        if product.child.count == 0 {
            childInfo.isHidden = true
        } else {
            childInfo.isHidden = false
        }
        
        if product.level == 1 {
            spaceLvOne.isHidden = false
            spaceLvTwo.isHidden = true
        } else if product.level == 2 {
            spaceLvOne.isHidden = false
            spaceLvTwo.isHidden = false
        } else if product.level == 0 {
            spaceLvOne.isHidden = true
            spaceLvTwo.isHidden = true
        }
        
    }
}
