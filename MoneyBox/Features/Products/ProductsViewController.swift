//
//  ProductsViewController.swift
//  MoneyBox
//
//  Created by Glenn Ludszuweit on 26.02.24.
//

import UIKit

class ProductsViewController: UIViewController {
    private let viewModel: ProductsViewModel
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let accountHolderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalPlanValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        view.addSubview(headerView)
        headerView.addSubview(accountHolderLabel)
        headerView.addSubview(totalPlanValueLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            
            accountHolderLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            accountHolderLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            accountHolderLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            
            totalPlanValueLabel.topAnchor.constraint(equalTo: accountHolderLabel.bottomAnchor, constant: 10),
            totalPlanValueLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            totalPlanValueLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func updateUI() {
        // Update header with account holder information and total plan value
        accountHolderLabel.text = "Account Holder: \(AppUser.user?.firstName ?? "") \(AppUser.user?.lastName ?? "")"
        if let totalPlanValue = viewModel.totalPlanValue {
            totalPlanValueLabel.text = "Total Plan Value: £\(String(totalPlanValue))"
        }
        
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
