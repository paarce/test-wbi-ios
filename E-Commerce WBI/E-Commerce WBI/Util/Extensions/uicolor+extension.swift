//
//  uicolor+extension.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/13/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    func getRGBModel() -> ProductColorRGBModel {
        
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {

            return ProductColorRGBModel(r: Float(fRed * 255.0) , g: Float(fGreen * 255.0) , b: Float(fBlue * 255.0))
        }else{
            
            return ProductColorRGBModel(r: 255.0 ,g: 255.0 ,b: 255.0)
        }
        
    }
    
}
