//
//  ProductDetailsViewModel.swift
//  Youtube MVVM Products
//
//  Created by KhaleD HuSsien on 25/01/2025.
//

import Foundation


import Foundation

final class ProductDetailsViewModel {
    
    
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    var productdetails: Product? = nil
    
    // MARK: - getProductDetails
    func getProductDetails(id: Int){
        self.eventHandler?(.loading)
        APIManager.shared.request(modelType: Product.self, type: ProductEndPoint.productDetails(id: id)) { result in
            self.eventHandler?(.stopLoading)
            switch result {
            case .success(let productDetails):
                self.eventHandler?(.getProductDetail(product: productDetails))
                self.productdetails = productDetails
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension ProductDetailsViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case getProductDetail(product: Product)
    }
}
