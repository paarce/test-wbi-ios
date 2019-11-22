//
//  CartItemTableViewCell.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/21/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import UIKit

class CartItemTableViewCell: UITableViewCell, CounterIntViewDelegate {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var counterView: CounterIntView!
    
    var data : CartItem?
    var parent : CartListViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.colorLabel.layer.masksToBounds = true
        self.colorLabel.layer.cornerRadius = colorLabel.frame.width/2
        self.colorLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.colorLabel.layer.borderWidth = 1.0
        
        
        self.sizeLabel.layer.masksToBounds = true
        self.sizeLabel.layer.cornerRadius = 4
        self.sizeLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.sizeLabel.layer.borderWidth = 1.0
        
    }
    
    override func draw(_ rect: CGRect) {
        
        if let data = self.data {
            self.nameLabel.text = data.productName
            self.priceLabel.text = "$\(data.price.dollar)"
            self.productImageView.image = UIImage(named:"product\(data.productImage)" )
            self.sizeLabel.text = data.size.rawValue
            self.colorLabel.backgroundColor = data.color.getColor()
            self.counterView.count = data.count
            self.counterView.delegate = self
        }
    }

    func updateAmount(count: Int) {
        
        if let data  = self.data {
            self.data?.count = count
            //ManagerRLM.sharedInstance.save(data)
            parent?.calculateTotal()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
