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
    
    
    let productCellHeight           : CGFloat = 256.0
    var productEntireCellHeight     : CGFloat {
        
        let countRows = self.products.count % 2 == 1 ? self.products.count + 1 : self.products.count
        
        return self.productCellHeight * ( CGFloat(countRows) / self.countItemInRow) + CGFloat(countRows * 10)
    }
    
    var countItemInRow : CGFloat {
        
        switch UIDevice.current.screenType {
        case .iPhones_5_5s_5c_SE, .iPhones_4_4S:
            return 1
        case .iPhones_6_6s_7_8:
            return 2
        default:
            return 3
        }
    }
    
    let stocks : [StockModel] = [
        StockModel(count: 3, size: .s, color: UIColor.black.rgbModel),
        StockModel(count: 2, size: .l, color: UIColor.blue.rgbModel),
        StockModel(count: 2, size: .l, color: UIColor.white.rgbModel),
        StockModel(count: 1, size: .xl, color: UIColor.blue.rgbModel)
    ]
    
    func loadCategories() {
        
        self.categories = [
            CategoryModel(id: 1, name: "Pants", ini: "PA"),
            CategoryModel(id: 2, name: "Shoes", ini: "SH"),
            CategoryModel(id: 3, name: "T-Shirts", ini: "TS"),
            CategoryModel(id: 4, name: "Watches", ini: "WA"),
            CategoryModel(id: 5, name: "Hoddies", ini: "HO"),
            CategoryModel(id: 6, name: "Accesories", ini: "AC")
        ]
        
    }
    
    func loadProducts() {
        
        self.products = [
            ProductModel(id: 1,name: "sss", imageName: "1", detail: "ssssss", price: 20.0, category: categories[0], stock: stocks),
            ProductModel(id: 2,name: "sss", imageName: "3", detail: "ssssss", price: 20.0, category: categories[2], stock: stocks),
            ProductModel(id: 3,name: "sss", imageName: "4", detail: "ssssss", price: 30.0, category: categories[4], stock: stocks),
            ProductModel(id: 4,name: "sss", imageName: "2", detail: "ssssss", price: 22.0, category: categories[1], stock: stocks),
            ProductModel(id: 5,name: "sss", imageName: "3", detail: "ssssss", price: 26.0, category: categories[1], stock: stocks),
            ProductModel(id: 6,name: "sss", imageName: "1", detail: "ssssss", price: 21.0, category: categories[3], stock: stocks),
            ProductModel(id: 7,name: "sss", imageName: "2", detail: "ssssss", price: 22.0, category: categories[2], stock: stocks),
        ]
        
    }
    
}
