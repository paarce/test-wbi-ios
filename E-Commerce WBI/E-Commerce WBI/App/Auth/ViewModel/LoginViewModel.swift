//
//  LoginViewModel.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/21/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let erroMessage: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    func perfomLogin( email : String?, password : String? ,  completion : @escaping () -> () ){
        
        defaults.set(email, forKey: KeysEnum.user_email.rawValue)
        completion()
        
    }
    
    func validateForm(email : String?, password : String? ) -> Bool {
        
        if password != nil && email != nil && !email!.isEmpty && !password!.isEmpty {
            
            return email!.isValidEmail() && password!.count >= 4
        }
            
         self.erroMessage.accept("Please complete the fields")
        
        return false
    }
    
}
