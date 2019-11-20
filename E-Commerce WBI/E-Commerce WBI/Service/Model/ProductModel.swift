//
//  ProductModel.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/13/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation
import UIKit

struct ProductModel  {
    
    let name : String?
    let imageName : String?
    let detail : String?
    let price : Float?
    let category : CategoryModel
    let stock : [StockModel]

    func hasStock( size: SizeEnum? = nil) -> Bool {
        
        if let size = size {
            return (self.stock.map { $0.size == size }).count > 0
        }
        
        return !self.stock.isEmpty
    }
    
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
    
    func getColor() -> UIColor {
        return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 0.8)
    }
    
}


struct CategoryModel  {
    
    let id : Int
    let name : String
    let ini : String
}


enum SizeEnum : String{
    case s = "S"
    case m = "M"
    case l = "L"
    case xl = "XL"
    
}
