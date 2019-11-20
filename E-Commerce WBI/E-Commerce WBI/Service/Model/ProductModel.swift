//
//  ProductModel.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/13/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation


struct ProductModel  {
    
    let name : String?
    let imageName : String?
    let detail : String?
    let price : Float?
    let category : CategoryModel
    let stock : [StockModel]

}



struct StockModel  {
    
    let count : Int
    let size : SizeEnum
    let color : ProductColorRGBModel
    
}


struct ProductColorRGBModel  {
    
    let r : Float
    let g : Float
    let b : Float
    
}


struct CategoryModel  {
    
    let id : Int
    let name : String
    let ini : String
}


enum SizeEnum : String {
    case s = "S"
    case m = "M"
    case l = "L"
    case xl = "XL"
}
