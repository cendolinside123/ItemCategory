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
    case independentV2
}

protocol ListProductHelperGuide {
    func cellExpandValidation(listIndex: [Int], status: Bool, tableView: UITableView)
    func cellDisplayControll(tableView: UITableView, type: VCType, indexPath: IndexPath, product: Product, selectedText: String) -> UITableViewCell
    func cellHighControll(type: VCType, product: Product) -> CGFloat
}
