//
//  CounterIntView.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/21/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation
import UIKit

class CounterIntView: UIView {
    
    var minusButton : UIButton?
    var plusButton : UIButton?
    var counterLabel : UILabel?
    var count : Int = 1 {
        didSet{
            self.counterLabel?.text = "\(self.count)"
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        if let counter = self.viewWithTag(0) as? UILabel, let minus = self.viewWithTag(1) as? UIButton, let plus = self.viewWithTag(2) as? UIButton {
            
            self.minusButton = minus
            self.plusButton = plus
            self.counterLabel = counter
            
            
            self.minusButton!.addTarget(self, action: #selector(CounterIntView.actionWithParam(sender:)), for: .touchUpInside)
            
        }
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4
    }
    
    @objc func actionWithParam(sender: UIButton){
        //...
    }
}
