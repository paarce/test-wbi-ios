//
//  ProductCollectionViewCell.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/13/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var data : String?
    
    override func draw(_ rect: CGRect) {
        if let data = data {
            self.imageView.image = UIImage(named: data)
            self.nameLabel.text = data
            self.typeLabel.text = data
        }
    }
    
}
