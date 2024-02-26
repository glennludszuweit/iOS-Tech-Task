//
//  ProductsViewModel.swift
//  MoneyBox
//
//  Created by Glenn Ludszuweit on 26.02.24.
//

import Networking

final class ProductsViewModel: ProductsViewModelProtocol {
    private let dataProvider: DataProvider
    
    var products: [ProductResponse]?
    var totalPlanValue: Double?
    
    var updatedState: (() -> Void)?

    var state: ProductsModelState {
        didSet {
            updatedState?()
        }
    }
    
    init(dataProvider: DataProvider = DataProvider()) {
        self.dataProvider = dataProvider
        state = .notLoaded
    }
    
    func getProducts() {
        state = .loading
        self.dataProvider.fetchProducts { response in
            switch response {
            case let .success(response):
                if let products = response.productResponses {
                    self.products = products
                }
                self.totalPlanValue = response.totalPlanValue
                self.state = .loaded
            case .failure(_):
                self.state = .error("Network error, please retry")
                break
            }
        }
    }
}

enum ProductsModelState {
    case notLoaded
    case loading
    case loaded
    case error(String?)
}
