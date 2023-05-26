//
//  MyProductsViewModel_Tests.swift
//  ZenventoryTests
//
//  Created by Sebastian Hajduk on 02/05/2023.
//

import XCTest
@testable import Zenventory

final class MyProductsViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: ---SORTING TESTS---

    func test_MyProductsViewModel_observingSorting_shouldSortByLowestPrice() {
        // Given
        let data = MockCoreData()
        data.addProduct(name: "", guarantee: 1, careName: "", careInterval: 1, price: 2, importance: "medium")
        data.addProduct(name: "", guarantee: 3, careName: "", careInterval: 3, price: 3, importance: "medium")
        data.addProduct(name: "", guarantee: 2, careName: "", careInterval: 2, price: 1, importance: "medium")
        data.addProduct(name: "", guarantee: 2, careName: "", careInterval: 2, price: 4, importance: "medium")
        try? data.fetchProducts()
        let myProductsViewModel = MyProductsViewModel(dataService: data)

        // When
        myProductsViewModel.sortingType = .lowestPrice

        // Then
        XCTAssertEqual(1, myProductsViewModel.myProducts[0].price)
        XCTAssertEqual(2, myProductsViewModel.myProducts[1].price)
        XCTAssertEqual(3, myProductsViewModel.myProducts[2].price)
        XCTAssertEqual(4, myProductsViewModel.myProducts[3].price)
    }

    func test_MyProductsViewModel_observingSorting_shouldSortByHighestPrice() {
        // Given
        let data = MockCoreData()
        data.addProduct(name: "", guarantee: 1, careName: "", careInterval: 1, price: 2, importance: "medium")
        data.addProduct(name: "", guarantee: 3, careName: "", careInterval: 3, price: 3, importance: "medium")
        data.addProduct(name: "", guarantee: 2, careName: "", careInterval: 2, price: 1, importance: "medium")
        data.addProduct(name: "", guarantee: 2, careName: "", careInterval: 2, price: 4, importance: "medium")
        try? data.fetchProducts()
        let myProductsViewModel = MyProductsViewModel(dataService: data)

        // When
        myProductsViewModel.sortingType = .highestPrice

        // Then
        XCTAssertEqual(4, myProductsViewModel.myProducts[0].price)
        XCTAssertEqual(3, myProductsViewModel.myProducts[1].price)
        XCTAssertEqual(2, myProductsViewModel.myProducts[2].price)
        XCTAssertEqual(1, myProductsViewModel.myProducts[3].price)
    }

    func test_MyProductsViewModel_observingSorting_shouldSortByNameAZ() {
        // Given
        let data = MockCoreData()
        data.addProduct(name: "D", guarantee: 1, careName: "", careInterval: 1, price: 2, importance: "medium")
        data.addProduct(name: "B", guarantee: 3, careName: "", careInterval: 3, price: 3, importance: "medium")
        data.addProduct(name: "A", guarantee: 2, careName: "", careInterval: 2, price: 1, importance: "medium")
        data.addProduct(name: "C", guarantee: 2, careName: "", careInterval: 2, price: 4, importance: "medium")
        try? data.fetchProducts()
        let myProductsViewModel = MyProductsViewModel(dataService: data)

        // When
        myProductsViewModel.sortingType = .nameAZ

        // Then
        XCTAssertEqual("A", myProductsViewModel.myProducts[0].name)
        XCTAssertEqual("B", myProductsViewModel.myProducts[1].name)
        XCTAssertEqual("C", myProductsViewModel.myProducts[2].name)
        XCTAssertEqual("D", myProductsViewModel.myProducts[3].name)
    }

    func test_MyProductsViewModel_observingSorting_shouldSortByNameZA() {
        // Given
        let data = MockCoreData()
        data.addProduct(name: "D", guarantee: 1, careName: "", careInterval: 1, price: 2, importance: "medium")
        data.addProduct(name: "B", guarantee: 3, careName: "", careInterval: 3, price: 3, importance: "medium")
        data.addProduct(name: "A", guarantee: 2, careName: "", careInterval: 2, price: 1, importance: "medium")
        data.addProduct(name: "C", guarantee: 2, careName: "", careInterval: 2, price: 4, importance: "medium")
        try? data.fetchProducts()
        let myProductsViewModel = MyProductsViewModel(dataService: data)

        // When
        myProductsViewModel.sortingType = .nameZA

        // Then
        XCTAssertEqual("D", myProductsViewModel.myProducts[0].name)
        XCTAssertEqual("C", myProductsViewModel.myProducts[1].name)
        XCTAssertEqual("B", myProductsViewModel.myProducts[2].name)
        XCTAssertEqual("A", myProductsViewModel.myProducts[3].name)
    }

    func test_MyProductsViewModel_observingSorting_shouldSortByDateAdded() {
        // Given
        let data = MockCoreData()
        data.addProduct(name: "D", guarantee: 1, careName: "", careInterval: 1, price: 2, importance: "medium")
        data.addProduct(name: "B", guarantee: 3, careName: "", careInterval: 3, price: 3, importance: "medium")
        data.addProduct(name: "A", guarantee: 2, careName: "", careInterval: 2, price: 1, importance: "medium")
        data.addProduct(name: "C", guarantee: 2, careName: "", careInterval: 2, price: 4, importance: "medium")
        try? data.fetchProducts()
        let myProductsViewModel = MyProductsViewModel(dataService: data)
        myProductsViewModel.sortingType = .nameZA

        // When
        myProductsViewModel.sortingType = .addedDate

        // Then
        XCTAssertEqual("D", myProductsViewModel.myProducts[0].name)
        XCTAssertEqual("B", myProductsViewModel.myProducts[1].name)
        XCTAssertEqual("A", myProductsViewModel.myProducts[2].name)
        XCTAssertEqual("C", myProductsViewModel.myProducts[3].name)
    }

    //MARK: ---FILTERING TESTS---

    func test_MyProductsViewModel_filter_shouldFilterByPrice() {
        // Given
        let data = MockCoreData()
        data.addProduct(name: "D", guarantee: 1, careName: "", careInterval: 1, price: 2, importance: "medium")
        data.addProduct(name: "B", guarantee: 3, careName: "", careInterval: 3, price: 3, importance: "medium")
        data.addProduct(name: "A", guarantee: 2, careName: "", careInterval: 2, price: 1, importance: "medium")
        data.addProduct(name: "C", guarantee: 2, careName: "", careInterval: 2, price: 4, importance: "medium")
        try? data.fetchProducts()
        let myProductsViewModel = MyProductsViewModel(dataService: data)
        myProductsViewModel.minPrice = "2"
        myProductsViewModel.maxPrice = "3"

        // When
        myProductsViewModel.filter() { }

        // Then
        XCTAssertEqual(2, myProductsViewModel.myProducts.count)
        XCTAssertTrue(myProductsViewModel.myProducts.contains(where: { $0.price == 2 }))
        XCTAssertTrue(myProductsViewModel.myProducts.contains(where: { $0.price == 3 }))
    }

    func test_MyProductsViewModel_filter_shouldFilterByImportance() {
        // Given
        let data = MockCoreData()
        data.addProduct(name: "D", guarantee: 1, careName: "", careInterval: 1, price: 2, importance: "high")
        data.addProduct(name: "B", guarantee: 3, careName: "", careInterval: 3, price: 3, importance: "medium")
        data.addProduct(name: "A", guarantee: 2, careName: "", careInterval: 2, price: 1, importance: "low")
        data.addProduct(name: "C", guarantee: 2, careName: "", careInterval: 2, price: 4, importance: "medium")
        try? data.fetchProducts()
        let myProductsViewModel = MyProductsViewModel(dataService: data)
        myProductsViewModel.useImportance = true
        myProductsViewModel.importance = .high

        // When
        myProductsViewModel.filter() { }

        // Then
        XCTAssertEqual(1, myProductsViewModel.myProducts.count)
        XCTAssertTrue(myProductsViewModel.myProducts.contains(where: { $0.importance == "high" }))
    }
}
