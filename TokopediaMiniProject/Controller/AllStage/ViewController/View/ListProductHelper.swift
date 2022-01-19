//
//  ListProductHelper.swift
//  TokopediaMiniProject
//
//  Created by Mac on 19/01/22.
//

import Foundation
import UIKit

struct ListProductHelper {
    
}

extension ListProductHelper: ListProductHelperGuide {
    func cellHighControll(type: VCType, product: Product) -> CGFloat {
        if type == .independentV2 && product.level == 2 {
            return 150
        } else {
            return 50
        }
    }
    
    
    func cellExpandValidation(listIndex: [Int], status: Bool, tableView: UITableView) {
        
        var getlListIndex: [IndexPath] = []
        if status == true {
            getlListIndex = listIndex.map({ (getIndex) -> IndexPath in
                return IndexPath(row: getIndex, section: 0)
            })
            tableView.beginUpdates()
            tableView.insertRows(at: getlListIndex, with: .automatic)
            tableView.endUpdates()

        } else {
            getlListIndex = listIndex.map({ (getIndex) -> IndexPath in
                return IndexPath(row: getIndex, section: 0)
            })
            tableView.beginUpdates()
            tableView.deleteRows(at: getlListIndex, with: .fade)
            tableView.endUpdates()
        }
        
    }
    
    func cellDisplayControll(tableView: UITableView, type: VCType, indexPath: IndexPath, product: Product, selectedText: String) -> UITableViewCell {
        
        if type == .independentV2 && product.level == 2 {
//            return UITableViewCell()
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductV2Cell", for: indexPath) as? ProductV2TableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.setupData(dummyProduct: product)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            
            cell.setProductInfo(product: product, searchText: selectedText)
            
            return cell
        }
    }
    
    
}
