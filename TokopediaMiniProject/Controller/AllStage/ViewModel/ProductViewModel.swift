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
                getResult.append(Product(id: product.id, name: product.name, identifier: product.identifier, url: product.url, iconImageUrl: product.iconImageUrl, parentName: product.parentName, applinks: product.applinks, iconBannerURL: product.iconImageUrl, child: getChild, level: product.level))
            }
            
        }
        
        return getResult
    }
}

extension ProductViewModel: ProductVMGuideline {
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
            self.filterResult?(self.result)
            return
        }
        
        self.tempProduct = self.result
        self.result = filterProduct(keyWord: keyword, listProduct: self.result)
        self.filterResult?(self.result)
    }
    
    
}
