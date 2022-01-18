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
    func boldSelectedText(product: Product, labelName: UILabel, text: String) {
        if product.name.lowercased().contains(text.lowercased()) {
            
            let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: labelName.font.pointSize)]
            var getText = NSMutableAttributedString(string: "", attributes: [:])
            var tempText: String = ""
            
            for aLetters in Array(product.name) {
                tempText += "\(aLetters)"
                if tempText.lowercased().contains(text.lowercased()) {
                    tempText = tempText.lowercased().replacingOccurrences(of: text.lowercased(), with: "")
                    getText = NSMutableAttributedString(string: tempText, attributes: [:])
                    if tempText.count == 0 || tempText.last == " " {
                        let boldText = NSMutableAttributedString(string: text.firstUppercased(), attributes:attrs)
                        getText.append(boldText)
                    } else {
                        let boldText = NSMutableAttributedString(string: text.lowercased(), attributes:attrs)
                        getText.append(boldText)
                    }
                } else {
                    getText.append(NSMutableAttributedString(string: "\(aLetters)", attributes: [:]))
                }
            }
            
            
            labelName.text = ""
            labelName.attributedText = getText
        }
    }
    
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
