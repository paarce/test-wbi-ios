//
//  ProductDetailViewController.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/19/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var isVisibleNavigation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
        
        self.scrollView.delegate = self
        //self.scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setBackgraoundNavigation(visible: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.setBackgraoundNavigation(visible: false)
    }
    
    func setBackgraoundNavigation( visible : Bool ) {
        
        if (visible && !isVisibleNavigation) || (!visible && isVisibleNavigation) { return }
        
        if visible {
            
            self.navigationController?.clearBrackgorund()
        }else {
            
            self.navigationController?.defaultBrackgorund()
        }
        self.isVisibleNavigation = !isVisibleNavigation
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //
        print(nameLabel.frame)
        
        self.setBackgraoundNavigation( visible : scrollView.bounds.contains(nameLabel.frame) )
       
    }

}
