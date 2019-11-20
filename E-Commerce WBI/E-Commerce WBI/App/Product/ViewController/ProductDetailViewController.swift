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
    
    var data : ProductModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            self.navigationController?.navigationBar.topItem?.title = ""
        }else {
            
            self.navigationController?.defaultBrackgorund()
            self.navigationController?.navigationBar.topItem?.title = data?.name
        }
        self.isVisibleNavigation = !isVisibleNavigation
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.setBackgraoundNavigation( visible : scrollView.bounds.contains(nameLabel.frame) )
       
    }

}
