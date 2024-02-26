//
//  ProductServices.swift
//  MoneyBox
//
//  Created by Glenn Ludszuweit on 26.02.24.
//

import Foundation
import Networking

protocol ProductsViewModelProtocol {
    var products: [ProductResponse]? { get }
    var totalPlanValue: Double? { get }
    var state: ProductsModelState { get }
    var updatedState: (() -> Void)? { get set }
    
    func getProducts()
}
