//
//  CounterIntView.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/21/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation
import UIKit

protocol CounterIntViewDelegate {
    func updateAmount(count : Int)
}

class CounterIntView: UIView {
    
    var minusButton : UIButton?
    var plusButton : UIButton?
    var counterLabel : UILabel?
    var count : Int = 1 {
        didSet{
            self.counterLabel?.text = "\(self.count)"
        }
    }
    
    var delegate : CounterIntViewDelegate?
    
    override func draw(_ rect: CGRect) {
        
        if let minus = self.viewWithTag(1) as? UIButton,  let counter = self.viewWithTag(2) as? UILabel, let plus = self.viewWithTag(3) as? UIButton {
            
            self.minusButton = minus
            self.plusButton = plus
            self.counterLabel = counter
            
            self.plusButton!.addTarget(self, action: #selector(CounterIntView.action(sender:)), for: .touchUpInside)
            self.minusButton!.addTarget(self, action: #selector(CounterIntView.action(sender:)), for: .touchUpInside)
            self.counterLabel!.text = "\(self.count)"
        }
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4
    }
    
    @objc func action(sender: UIButton){
        
        if sender.tag == 1 {
            self.count = self.count == 0 ? 0 : self.count - 1
            delegate?.updateAmount(count: self.count)
        }else if sender.tag == 3 {
             self.count += 1
            delegate?.updateAmount(count: self.count)
        }
    }
}
