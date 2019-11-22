//
//  StockModel.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/21/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation
import UIKit

struct StockModel  {
    
    let count : Int
    let size : SizeEnum
    let color : ProductColorRGBModel
    
}

struct ProductColorRGBModel : Comparable, Hashable {
    
    let r : Float
    let g : Float
    let b : Float
    
    func getColor() -> UIColor {
        return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: 0.8)
    }
    
    
    static func < (lhs: ProductColorRGBModel, rhs: ProductColorRGBModel) -> Bool {
        var returnValue = false
        if (lhs.r < rhs.r) && (lhs.g < rhs.g) && (lhs.b < rhs.b)
        {
            returnValue = true
        }
        return returnValue
    }
    
    static func == (lhs: ProductColorRGBModel, rhs: ProductColorRGBModel) -> Bool {
        var returnValue = false
        if (lhs.r == rhs.r) && (lhs.g == rhs.g) && (lhs.b == rhs.b)
        {
            returnValue = true
        }
        return returnValue
    }
    
}

enum SizeEnum : String, CaseIterable{
    case s = "S"
    case m = "M"
    case l = "L"
    case xl = "XL"
    
}
