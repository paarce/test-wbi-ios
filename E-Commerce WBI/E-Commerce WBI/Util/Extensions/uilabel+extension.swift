//
//  uilabel+extension.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/21/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift


extension UILabel {
    
    func unselect() {
        self.backgroundColor = .lightGray
    }
    
    func select() {
        self.backgroundColor = .greenEco
    }
    
    func showError() {
        self.backgroundColor = .red
    }
    
}


extension UIViewController {

    func setLoading(){
        
        self.view.isUserInteractionEnabled = false
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.view.makeToastActivity(.center)
    }
    
    
    func removeLoading(){
        
        self.view.isUserInteractionEnabled = true
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        self.navigationItem.setHidesBackButton(false, animated:true);
        self.view.hideToastActivity()
    }

}
