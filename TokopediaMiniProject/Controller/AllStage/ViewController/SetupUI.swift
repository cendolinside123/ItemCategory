//
//  SetupUI.swift
//  TokopediaMiniProject
//
//  Created by Mac on 16/01/22.
//

import Foundation
import UIKit

enum VCType {
    case independent
    case popup
}

protocol ListProductHelperGuide {
    func cellExpandValidation(listIndex: [Int], status: Bool)
    func updateExpandValidation(product: [Product])
    func cellDisplayControll(tableView: UITableView, type: VCType, indexPath: IndexPath, product: Product) -> UITableViewCell
    func selectValidation(product: Product, type: VCType)
}
