//
//  CartItemTableViewCell.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/21/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var counterView: CounterIntView!
    
    var data : CartItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        colorLabel.layer.masksToBounds = true
        colorLabel.layer.cornerRadius = colorLabel.frame.width/2
        colorLabel.layer.borderColor = UIColor.lightGray.cgColor
        colorLabel.layer.borderWidth = 1.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
