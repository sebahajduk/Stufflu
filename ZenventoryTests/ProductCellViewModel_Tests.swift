//
//  ProductCellViewModel_Tests.swift
//  ZenventoryTests
//
//  Created by Sebastian Hajduk on 25/05/2023.
//

import XCTest
@testable import Zenventory

final class ProductCellViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ProductCellViewModel_init() {
        let mock = MockCoreData()
        mock.addProduct(name: "Test", guarantee: 1, careName: "Test", careInterval: 1, price: 1, importance: "medium")

        try? mock.fetchProducts()

        let product: ProductEntity = mock.savedProductEntities[0]
        let productCellViewModel: ProductCellViewModel = .init(product: product)

        XCTAssertEqual(product.name, productCellViewModel.product.name)
        XCTAssertEqual(product.guarantee, productCellViewModel.product.guarantee)
        XCTAssertEqual(product, productCellViewModel.product)
    }

    func test_ProductCellViewModel_init_productHasNoLastUsed() {
        let mock = MockCoreData()
        mock.addProduct(name: "Test", guarantee: 1, careName: "Test", careInterval: 1, price: 1, importance: "medium")

        try? mock.fetchProducts()

        let product: ProductEntity = mock.savedProductEntities[0]
        product.lastUsed = nil

        let productCellViewModel: ProductCellViewModel = .init(product: product)

        XCTAssertEqual(productCellViewModel.lastUsed, "Unknown")
    }

    func test_ProductCellViewModel_init_productHasNoName() {
        let mock = MockCoreData()
        mock.addProduct(name: "Test", guarantee: 1, careName: "Test", careInterval: 1, price: 1, importance: "medium")

        try? mock.fetchProducts()

        let product: ProductEntity = mock.savedProductEntities[0]
        product.name = nil

        let productCellViewModel: ProductCellViewModel = .init(product: product)

        XCTAssertEqual(productCellViewModel.productImage, nil)
    }

}
