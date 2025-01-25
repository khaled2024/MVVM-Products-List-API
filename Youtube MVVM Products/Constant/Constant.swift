//
//  Constant.swift
//  Youtube MVVM Products
//
//  Created by Yogesh Patel on 23/12/22.
//

enum Constant {
    enum API {
        static let productURL = "https://fakestoreapi.com/products"
    }
    static var commonHeaders: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }
}

// use double don't use float
