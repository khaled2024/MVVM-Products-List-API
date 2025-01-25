//
//  UIAlert.swift
//  Youtube MVVM Products
//
//  Created by KhaleD HuSsien on 25/01/2025.
//

import UIKit
extension UIViewController{
    func showAlert(title: String, message: String,completion: ((UIAlertAction) -> Void)? = nil){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
            self.present(alert, animated: true)
        }
    }
}
