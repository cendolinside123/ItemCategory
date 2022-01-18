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
    
    func testDummyFilterCompareData() {
        let useCase: StageNetworkProvider = SuccessDataUseCase()
        viewModel = ProductViewModel(useCase: useCase)
        let loadExpectation = expectation(description: "should return product data")
        let filterExpectation = expectation(description: "filtered product data sould same")
        let expectedResult = MockData.getListDapurProductNew()
        
        viewModel?.productResult = { result in
            XCTAssertGreaterThan(result.count, 0)
            loadExpectation.fulfill()
        }
        
        viewModel?.filterResult = { filteredResult in
            XCTAssertGreaterThan(filteredResult.count, 0)
            XCTAssertEqual(filteredResult, expectedResult)
            filterExpectation.fulfill()
        }
        
        viewModel?.loadProduct(reloadTime: 3)
        wait(for: [loadExpectation], timeout: 1)
        viewModel?.searchProduct(keyword: "Dapur")
        wait(for: [filterExpectation], timeout: 1)
    }
    
    func testBasicFilterCompareData() {
        let useCase: StageNetworkProvider = BasicStageUseCase()
        viewModel = ProductViewModel(useCase: useCase)
        let loadExpectation = expectation(description: "should return product data")
        let filterExpectation = expectation(description: "filtered product data sould same")
        let expectedResult = MockData.getListDapurProductNew()
        
        viewModel?.productResult = { result in
            XCTAssertGreaterThan(result.count, 0)
            loadExpectation.fulfill()
        }
        
        viewModel?.filterResult = { filteredResult in
            XCTAssertGreaterThan(filteredResult.count, 0)
            XCTAssertEqual(filteredResult, expectedResult)
            filterExpectation.fulfill()
        }
        
        viewModel?.loadProduct(reloadTime: 3)
        wait(for: [loadExpectation], timeout: 1)
        viewModel?.searchProduct(keyword: "Dapur")
        wait(for: [filterExpectation], timeout: 1)
    }
    
    func testAdvanceLoadData() {
        let useCase: StageNetworkProvider = SpecialStageUseCase()
        viewModel = ProductViewModel(useCase: useCase)
        let loadExpectation = expectation(description: "should return product data")
        
        
        viewModel?.productResult = { result in
            XCTAssertGreaterThan(result.count, 0)
            loadExpectation.fulfill()
        }
        
        viewModel?.fetchError = { error in
            XCTAssertThrowsError(error.localizedDescription)
        }
        
        viewModel?.loadProduct(reloadTime: 3)
        wait(for: [loadExpectation], timeout: 10)
    }
    
    func testExpandSelectedData() {
        let useCase: StageNetworkProvider = SuccessDataUseCase()
        viewModel = ProductViewModel(useCase: useCase)
        let loadExpectation = expectation(description: "should return product data")
        let expandExpectation = expectation(description: "should expand product data")
        
        viewModel?.productResult = { result in
            XCTAssertGreaterThan(result.count, 0)
            loadExpectation.fulfill()
        }
        
        viewModel?.toggleResult = { listIndex, status in
            XCTAssertTrue(status)
            XCTAssertNotEqual(listIndex.count, 0)
            expandExpectation.fulfill()
        }
        
        viewModel?.loadProduct(reloadTime: 3)
        wait(for: [loadExpectation], timeout: 1)
        viewModel?.selectExpandProduct(product: Product(id: "0", name: "Pilihan Untukmu", identifier: "", url: "https://www.tokopedia.com/p", iconImageUrl: "https://ecs7.tokopedia.net/img/attachment/2020/3/19/77305583/77305583_1ef56963-5102-44b3-938a-8935e5aac773.png", parentName: "", applinks: "", iconBannerURL: "https://ecs7.tokopedia.net/img/attachment/2020/3/19/77305583/77305583_01009a39-c22b-4229-8e4c-327d0f51cf6b.png", child: [
            Product(id: "2700", name: "Makanan Ringan", identifier: "makanan-minuman_makanan-ringan", url: "https://www.tokopedia.com/p/makanan-minuman/makanan-ringan", iconImageUrl: "https://ecs7.tokopedia.net/img/attachment/2020/3/19/82120085/82120085_d861608c-32b9-4c27-af4e-2348100a4f78.png", parentName: "Makanan & Minuman", applinks: "tokopedia://category/2700?categoryName=Makanan+Ringan", iconBannerURL: "", child: [], level: 1) ,
            Product(id: "2149", name: "Perawatan Kaki & Tangan", identifier: "perawatan-tubuh_perawatan-kaki-tangan", url: "https://www.tokopedia.com/p/perawatan-tubuh/perawatan-kaki-tangan", iconImageUrl: "https://ecs7.tokopedia.net/img/attachment/2020/3/19/82120085/82120085_15b61fa7-bece-4c9a-8032-67fb48beab10.png", parentName: "Perawatan Tubuh", applinks: "tokopedia://category/2149?categoryName=Perawatan+Kaki+%26+Tangan", iconBannerURL: "", child: [], level: 1)
        ], level: 0), type: .independent)
        wait(for: [expandExpectation], timeout: 1)
    }
    
}
