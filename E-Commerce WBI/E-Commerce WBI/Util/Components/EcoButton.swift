//
//  EcoButton.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/19/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation
import UIKit

class EcoButton : UIButton {
    
    override func draw(_ rect: CGRect) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4
    }
    
    func setOwned(enable : Bool) {
        self.isEnabled = enable
        self.backgroundColor = enable ? .greenEco : .lightGray
    }
}
