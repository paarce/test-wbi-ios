//
//  ProductModel.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/13/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation

struct ProductModel  {
    
    let id : Int
    let name : String?
    let imageName : String?
    let detail : String?
    let price : Float?
    let category : CategoryModel
    let stock : [StockModel]
    
}

