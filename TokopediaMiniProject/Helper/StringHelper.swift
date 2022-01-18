//
//  StringHelper.swift
//  TokopediaMiniProject
//
//  Created by Mac on 18/01/22.
//

import Foundation
extension String {
    func firstUppercased() -> String {
        return prefix(1).uppercased() + dropFirst()
        
    }
}
