//
//  ProductCardView.swift
//  MoneyBox
//
//  Created by Glenn Ludszuweit on 26.02.24.
//

import UIKit
import Networking

class ProductCardView: UIView {
    private var product: ProductResponse? {
        didSet {
            if product != nil {
                hideLoading()
            } else {
                showLoading()
            }
            configure(with: product)
        }
    }
    
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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(product: ProductResponse?) {
        self.product = product
        super.init(frame: .zero)
        setupViews()
        if product == nil {
            showLoading()
        } else {
            hideLoading()
        }
        configure(with: product)
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        addSubview(titleLabel)
        addSubview(planValueLabel)
        addSubview(moneyboxValueLabel)
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            planValueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            planValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            planValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            moneyboxValueLabel.topAnchor.constraint(equalTo: planValueLabel.bottomAnchor, constant: 5),
            moneyboxValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            moneyboxValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            moneyboxValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configure(with product: ProductResponse?) {
        if let product = product {
            titleLabel.text = product.product?.friendlyName
            
            if let planValue = product.planValue, let moneybox = product.moneybox {
                planValueLabel.text = "Plan value: £\(String(planValue))"
                moneyboxValueLabel.text = "Moneybox: £\(String(moneybox))"
            }
        } else {
            titleLabel.text = "Loading..."
            planValueLabel.text = nil
            moneyboxValueLabel.text = nil
        }
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    @objc private func handleTap() {
        // Navigate to ProductDetailViewController
        if let product = product {
            let productDetailVC = ProductDetailViewController(product: product)
            if let topViewController = UIApplication.topViewController() {
                topViewController.navigationController?.pushViewController(productDetailVC, animated: true)
            }
        }
    }
    
    private func showLoading() {
        activityIndicator.startAnimating()
        titleLabel.isHidden = true
        planValueLabel.isHidden = true
        moneyboxValueLabel.isHidden = true
    }
    
    private func hideLoading() {
        activityIndicator.stopAnimating()
        titleLabel.isHidden = false
        planValueLabel.isHidden = false
        moneyboxValueLabel.isHidden = false
    }
}
