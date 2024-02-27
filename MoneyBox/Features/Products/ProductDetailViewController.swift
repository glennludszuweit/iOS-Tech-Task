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
    
    init(product: ProductResponse) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
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
        
        // Display product details
        let titleLabel = UILabel()
        titleLabel.text = product.product?.name
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let planValueLabel = UILabel()
        planValueLabel.font = UIFont.systemFont(ofSize: 16)
        planValueLabel.numberOfLines = 0
        planValueLabel.translatesAutoresizingMaskIntoConstraints = false
        if let planValue = product.planValue {
            planValueLabel.text = "Plan value: £\(String(planValue))"
        }
        
        view.addSubview(titleLabel)
        view.addSubview(planValueLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            planValueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            planValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            planValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
