//
//  ProductCardView.swift
//  MoneyBox
//
//  Created by Glenn Ludszuweit on 26.02.24.
//

import UIKit
import Networking

class ProductCardView: UIView {
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
    
    init(product: ProductResponse) {
        super.init(frame: .zero)
        setupViews()
        configure(with: product)
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
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            planValueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            planValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            planValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            planValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            moneyboxValueLabel.topAnchor.constraint(equalTo: planValueLabel.bottomAnchor, constant: 5),
            moneyboxValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            moneyboxValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            moneyboxValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func configure(with product: ProductResponse) {
        titleLabel.text = product.product?.name
        if #available(iOS 15.0, *) {
            if let planValue = product.planValue {
                planValueLabel.text = "Plan value: £\(String(planValue))"
            }
            
            if let moneybox = product.moneybox {
                moneyboxValueLabel.text = "Moneybox: £\(String(moneybox))"
            }
        }
    }
}

