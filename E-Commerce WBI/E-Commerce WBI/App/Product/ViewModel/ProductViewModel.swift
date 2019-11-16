//
//  ProductViewModel.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/13/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation
import UIKit

class ProductViewModel {
    
    var products : [ProductModel] = []
    var categories : [CategoryModel] = []
    
    func loadCategories() {
        
        let p = [
            CategoryModel(id: 1, name: "Pants", ini: "PA"),
            CategoryModel(id: 2, name: "Shoes", ini: "SH"),
            CategoryModel(id: 3, name: "T-Shirts", ini: "TS"),
            CategoryModel(id: 4, name: "Watches", ini: "WA"),
            CategoryModel(id: 5, name: "Hoddies", ini: "HO"),
            CategoryModel(id: 6, name: "Accesories", ini: "AC")
        ]
        
        print(p)
    }
    
    func loadProducts() {
        
        let p = [
            ProductModel(name: "sss", imageName: "aaaa", detail: "ssssss", price: 20.0, category: categories[0], stock: []),
            ProductModel(name: "sss", imageName: "aaaa", detail: "ssssss", price: 20.0, category: categories[2], stock: []),
            ProductModel(name: "sss", imageName: "aaaa", detail: "ssssss", price: 30.0, category: categories[4], stock: []),
            ProductModel(name: "sss", imageName: "aaaa", detail: "ssssss", price: 22.0, category: categories[1], stock: []),
            ProductModel(name: "sss", imageName: "aaaa", detail: "ssssss", price: 26.0, category: categories[1], stock: []),
            ProductModel(name: "sss", imageName: "aaaa", detail: "ssssss", price: 21.0, category: categories[3], stock: []),
            ProductModel(name: "sss", imageName: "aaaa", detail: "ssssss", price: 22.0, category: categories[6], stock: []),
        ]
        
        print(p)
        
    }
    
}
