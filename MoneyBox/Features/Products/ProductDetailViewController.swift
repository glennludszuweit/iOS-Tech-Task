//
//  ProductDetailViewController.swift
//  MoneyBox
//
//  Created by Glenn Ludszuweit on 27.02.24.
//

import UIKit
import Networking

class ProductDetailViewController: UIViewController {
    private let product: ProductResponse
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let planValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moneyboxValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add £10", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor(red: 0, green: 194/255, blue: 181/255, alpha: 1), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0, green: 194/255, blue: 181/255, alpha: 1).cgColor
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addToMoneyboxButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.activityIndicator.startAnimating()
                    self.addButton.isEnabled = false
                } else {
                    self.activityIndicator.stopAnimating()
                    self.addButton.isEnabled = true
                }
            }
        }
    }
    
    init(product: ProductResponse) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
        setupViews()
        configure(with: product)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(planValueLabel)
        view.addSubview(moneyboxValueLabel)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            planValueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            planValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            planValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            moneyboxValueLabel.topAnchor.constraint(equalTo: planValueLabel.bottomAnchor, constant: 10),
            moneyboxValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            moneyboxValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addButton.topAnchor.constraint(equalTo: moneyboxValueLabel.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func configure(with product: ProductResponse) {
        titleLabel.text = product.product?.friendlyName
        
        if let planValue = product.planValue, let moneybox = product.moneybox {
            planValueLabel.text = "Plan value: £\(String(planValue))"
            moneyboxValueLabel.text = "Moneybox: £\(String(moneybox))"
        }
    }
    
    @objc private func addToMoneyboxButtonTapped() {
        // Create a OneOffPaymentRequest with the amount £10
        let paymentRequest = OneOffPaymentRequest(amount: 10, investorProductID: product.id!)
        
        // Set loading state
        isLoading = true
        
        // Call the API to add £10 to moneybox
        DataProvider().addMoney(request: paymentRequest) { [weak self] result in
            guard let self = self else { return }
            
            // Reset loading state
            self.isLoading = false
            
            switch result {
            case .success(let response):
                // Update UI with the new moneybox value, unwrapping the optional value
                if let moneybox = response.moneybox {
                    DispatchQueue.main.async {
                        self.moneyboxValueLabel.text = "Moneybox: £\(moneybox)"
                    }
                }
                print("Successfully added £10 to moneybox")
            case .failure(let error):
                // Handle failure or display error message
                print("Failed to add £10 to moneybox: \(error)")
            }
        }
    }
    
}
