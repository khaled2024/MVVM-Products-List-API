//
//  Extension+UIActivityIndecator.swift
//  Youtube MVVM Products
//
//  Created by KhaleD HuSsien on 25/01/2025.
//

import UIKit
extension UIViewController{
    func startLoading(activity: UIActivityIndicatorView){
        DispatchQueue.main.async {
            /// Indicator show
            print("Product loading....")
            activity.startAnimating()
            activity.isHidden = false
        }
    }
    
    func stopLoading(activity: UIActivityIndicatorView){
        DispatchQueue.main.async {
            // Indicator hide
            print("Stop loading...")
            activity.stopAnimating()
            activity.isHidden = true
        }
    }
}
