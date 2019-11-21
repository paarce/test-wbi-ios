//
//  string+extension.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/21/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation


extension String {
    
    func isValidEmail() -> Bool {
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", regexEmail)
        return emailTest.evaluate(with: self)
    }
    
}
