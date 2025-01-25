//
//  ProductDetailsViewController.swift
//  Youtube MVVM Products
//
//  Created by KhaleD HuSsien on 25/01/2025.
//

import UIKit
import Kingfisher
class ProductDetailsViewController: UIViewController {
    // MARK: - Outlets & Vars
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var descr: UILabel!
    @IBOutlet weak var productRate: UIButton!
    @IBOutlet weak var productCateg: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let viewModel = ProductDetailsViewModel()
    var productDetailsId: Int? = nil
    
    // MARK: - Didload
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    func configuration(){
        viewModel.getProductDetails(id: productDetailsId ?? 0)
        observeEvent()
    }
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                startLoading(activity: activityIndicator)
            case .stopLoading:
                stopLoading(activity: activityIndicator)
            case .dataLoaded:
                print("Data loaded...")
            case .error(let error):
                print(error ?? "")
            case .getProductDetail(product: let product):
                DispatchQueue.main.async {
                    self.assignProductDetails(product: product)
                }
            }
        }
    }
    private func assignProductDetails(product: Product){
        self.productImage.setImage(with: product.image)
        self.productTitle.text = product.title
        productCateg.text = product.category
        descr.text = product.description
        productPrice.text = "$\(product.price)"
        productRate.setTitle("\(product.rating.rate)", for: .normal)
    }
    
    @IBAction func buyTapped(_ sender: UIButton) {
        guard let productdetails = viewModel.productdetails else { return }
        self.showAlert(title: productdetails.title,message: "Thank you for your purchase 🎉") { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
