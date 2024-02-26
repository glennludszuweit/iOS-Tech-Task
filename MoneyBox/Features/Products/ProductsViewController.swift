//
//  ProductsViewController.swift
//  MoneyBox
//
//  Created by Glenn Ludszuweit on 26.02.24.
//

import UIKit

class ProductsViewController: UIViewController {
    private let viewModel: ProductsViewModel
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Custom initializer for dependency injection
    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.updatedState = { [weak self] in
            self?.updateUI()
        }
    }
    
    // Convenience initializer for storyboard/nib file initialization
    convenience init() {
        self.init(viewModel: ProductsViewModel())
    }
    
    // Required initializer for storyboard/nib file initialization
    required init?(coder: NSCoder) {
        // Provide a default value for viewModel
        self.viewModel = ProductsViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.getProducts()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func updateUI() {
        // Remove existing product views
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add product views
        if let products = viewModel.products {
            for product in products {
                let productView = ProductCardView(product: product)
                stackView.addArrangedSubview(productView)
            }
        }
    }
}
