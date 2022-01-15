//
//  ProductControllerUnitTest.swift
//  TokopediaMiniProjectTests
//
//  Created by Mac on 15/01/22.
//

import XCTest
@testable import TokopediaMiniProject

class ProductControllerUnitTest: XCTestCase {

    var viewModel: ProductVMGuideline?
    
    func testBasicLoadData() {
        let useCase: StageNetworkProvider = BasicStageUseCase()
        viewModel = ProductViewModel(useCase: useCase)
        let loadExpectation = expectation(description: "should return product data")
        
        
        viewModel?.productResult = { result in
            XCTAssertGreaterThan(result.count, 0)
            loadExpectation.fulfill()
        }
        
        viewModel?.loadProduct(reloadTime: 3)
        wait(for: [loadExpectation], timeout: 1)
        
    }

    func testBasicFilterData() {
        let useCase: StageNetworkProvider = BasicStageUseCase()
        viewModel = ProductViewModel(useCase: useCase)
        let loadExpectation = expectation(description: "should return product data")
        let filterExpectation = expectation(description: "should return filtered product data")
        
        viewModel?.productResult = { result in
            XCTAssertGreaterThan(result.count, 0)
            loadExpectation.fulfill()
        }
        
        viewModel?.filterResult = { filteredResult in
            XCTAssertGreaterThan(filteredResult.count, 0)
            filterExpectation.fulfill()
        }
        
        viewModel?.loadProduct(reloadTime: 3)
        wait(for: [loadExpectation], timeout: 1)
        viewModel?.searchProduct(keyword: "Dapur")
        wait(for: [filterExpectation], timeout: 1)
    }
    
}
