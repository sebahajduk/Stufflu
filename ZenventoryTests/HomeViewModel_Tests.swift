//
//  HomeViewModel_Tests.swift
//  ZenventoryTests
//
//  Created by Sebastian Hajduk on 25/05/2023.
//

import XCTest
@testable import Zenventory

final class HomeViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_HomeViewModel_deleteItem_shouldDelete() {
        let mock: MockCoreData = .init()

        mock.addProduct(name: "Test", guarantee: 1, careName: "Test", careInterval: 1, price: 1, importance: "medium")
        mock.addProduct(name: "Test", guarantee: 1, careName: "Test", careInterval: 1, price: 1, importance: "medium")
        mock.addProduct(name: "Test", guarantee: 1, careName: "Test", careInterval: 1, price: 1, importance: "medium")

        try? mock.fetchProducts()

        let homeViewModel: HomeViewModel = .init(dataService: mock)

        XCTAssertEqual(mock.savedEntities.count, 3)
        XCTAssertEqual(homeViewModel.products.count, 3)

        homeViewModel.deleteItem(at: IndexSet(integer: 0))

        try? mock.fetchProducts()

        XCTAssertEqual(homeViewModel.products.count, 2)
        XCTAssertEqual(mock.savedEntities.count, 2)

    }

}
