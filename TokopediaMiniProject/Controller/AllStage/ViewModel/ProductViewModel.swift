//
//  ProductViewModel.swift
//  TokopediaMiniProject
//
//  Created by Mac on 15/01/22.
//

import Foundation

class ProductViewModel {
    var productResult: (([Product]) -> Void)?
    var filterResult: (([Product]) -> Void)?
    var toggleResult: (([Int], Bool) -> Void)? //note: how to use, #1 param list of index 2# if false mean delete true mean adding
    var fetchError: ((Error) -> Void)?
    var result: [Product] = []
    private var tempProduct: [Product] = []
    
    private var useCase: StageNetworkProvider
    
    
    init(useCase: StageNetworkProvider) {
        self.useCase = useCase
    }
    
}

extension ProductViewModel {
    private func filterProduct(keyWord: String, listProduct: [Product]) -> [Product] {
        var getResult: [Product] = []
        
        for product in listProduct {
            
            let getChild: [Product] = self.filterProduct(keyWord: keyWord, listProduct: product.child)
            
            if product.name.contains(keyWord) || getChild.count > 0 {
                getResult.append(Product(id: product.id, name: product.name, identifier: product.identifier, url: product.url, iconImageUrl: product.iconImageUrl, parentName: product.parentName, applinks: product.applinks, iconBannerURL: product.iconBannerURL, child: getChild, level: product.level, root: product.root))
            }
            
        }
        
        return getResult
    }
    
    private func populateAlSearch(listProduct: [Product]) -> [Product]{
        var getResult: [Product] = []
        
        for product in listProduct {
            
            let getChild: [Product] = populateAlSearch(listProduct: product.child)
            
            getResult.append(Product(id: product.id, name: product.name, identifier: product.identifier, url: product.url, iconImageUrl: product.iconImageUrl, parentName: product.parentName, applinks: product.applinks, iconBannerURL: product.iconBannerURL, child: product.child, level: product.level, root: product.root))
            if getChild.count > 0 {
                getResult += getChild
            }
            
        }
        
        return getResult
    }
}

extension ProductViewModel: ProductVMGuideline {
    func hideSpesificProduct(child: [Product]) {
        var listIndex: [Int] = []
        
        for getProduct in child {
            if let getIndex = self.result.firstIndex(where: { $0 == getProduct }) {
                listIndex.append(getIndex)
            }
        }
        
        for getProduct in child {
            if let getIndex = self.result.firstIndex(where: { $0 == getProduct }) {
                self.result.remove(at: getIndex)
            }
        }
        self.toggleResult?(listIndex, false)
    }
    
    func expandProduct(child: [Product]) {
        if self.tempProduct.count == 0 {
            self.tempProduct = self.result
        }
        
        if let getIndex = self.result.firstIndex(where: {$0.child == child}), getIndex + 1 <= self.result.count {
            self.result.insert(contentsOf: child, at: getIndex + 1)
            
            var listIndex: [Int] = []
            
            for index in 0...child.count - 1 {
                listIndex.append((getIndex + 1) + index)
            }
            self.toggleResult?(listIndex, true)
        }
        
    }
    
    func hideAllProduct(id: String) {
        
        let getAllRemovedChild = self.result.filter({
            $0.root == id
        }).count
        
        if let getIndex = self.result.firstIndex(where: {$0.root == id}) {
            var listIndex: [Int] = []
            for index in 0...getAllRemovedChild - 1 {
                listIndex.append(getIndex + index)
            }
            self.result.removeAll(where: {
                $0.root == id
            })
            self.toggleResult?(listIndex, false)
        }
    }
    
    func loadProduct(reloadTime: Int) {
        useCase.fetchProduct(completion: { [weak self] response in
            switch response {
            case .success(let result):
                self?.result = result
                self?.productResult?(result)
            case .failed(let error):
                if reloadTime > 0 {
                    self?.loadProduct(reloadTime: reloadTime - 1)
                } else {
                    self?.fetchError?(error)
                }
            }
        })
    }
    
    func searchProduct(keyword: String) {
        if keyword == "" {
            self.result = self.tempProduct
            self.tempProduct = []
            self.productResult?(self.result)
            return
        }
        
        if self.tempProduct.count == 0 {
            self.tempProduct = self.result
        } else {
            self.result = self.tempProduct
        }
        
        self.result = filterProduct(keyWord: keyword, listProduct: self.result)
        self.result = populateAlSearch(listProduct: self.result)
        self.filterResult?(self.result)
    }
    
    
}
