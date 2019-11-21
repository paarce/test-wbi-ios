//
//  StockModel.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/21/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation


struct StockModel  {
    
    let count : Int
    let size : SizeEnum
    let color : ProductColorRGBModel
    
}

enum SizeEnum : String, CaseIterable{
    case s = "S"
    case m = "M"
    case l = "L"
    case xl = "XL"
    
}
