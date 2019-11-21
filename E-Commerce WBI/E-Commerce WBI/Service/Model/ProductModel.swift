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
    
    let id : Int
    let name : String?
    let imageName : String?
    let detail : String?
    let price : Float?
    let category : CategoryModel
    let stock : [StockModel]
    
}

struct ProductColorRGBModel  {
    
    let r : Float
    let g : Float
    let b : Float
    
    func getColor() -> UIColor {
        return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 0.8)
    }
    
}
