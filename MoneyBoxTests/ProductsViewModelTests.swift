//
//  ProductsViewModelTests.swift
//  MoneyBoxTests
//
//  Created by Glenn Ludszuweit on 27.02.24.
//

import XCTest
@testable import MoneyBox
@testable import Networking

class MockDataProvider: DataProvider {
    var productsResult: Result<[ProductResponse], Error>?
    var totalPlanValueResult: Result<Double, Error>?

    func fetchProducts(completion: @escaping (Result<[ProductResponse], Error>) -> Void) {
        if let result = productsResult {
            completion(result)
        } else {
            completion(.failure(MockError.mockError))
        }
    }

    func fetchTotalPlanValue(completion: @escaping (Result<Double, Error>) -> Void) {
        if let result = totalPlanValueResult {
            completion(result)
        } else {
            completion(.failure(MockError.mockError))
        }
    }
}

enum MockError: Error {
    case mockError
}

class ProductsViewModelTests: XCTestCase {
    var mockDataProvider: MockDataProvider!
    var viewModel: ProductsViewModelProtocol!

    override func setUp() {
        super.setUp()
        mockDataProvider = MockDataProvider()
        viewModel = ProductsViewModel(dataProvider: mockDataProvider)
    }

    override func tearDown() {
        mockDataProvider = nil
        viewModel = nil
        super.tearDown()
    }

    func testGetProductsSuccess() {
        // Given
        let expectedProducts: [ProductResponse] = [/* Create some sample products */]
        let expectedTotalPlanValue: Double = 1000
        mockDataProvider.productsResult = .success(expectedProducts)
        mockDataProvider.totalPlanValueResult = .success(expectedTotalPlanValue)

        // When
        viewModel.getProducts()

        // Then
        XCTAssertNotNil(viewModel.products)
        XCTAssertNotNil(viewModel.totalPlanValue)
    }

    func testGetProductsFailure() {
        // Given
        mockDataProvider.productsResult = .failure(MockError.mockError)
        mockDataProvider.totalPlanValueResult = .failure(MockError.mockError)

        // When
        viewModel.getProducts()

        // Then
        XCTAssertNil(viewModel.products)
        XCTAssertNil(viewModel.totalPlanValue)
    }
}

