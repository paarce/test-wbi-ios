//
//  CartListViewController.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/21/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CartListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var data : [CartItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data.append(CartItem(productId: 1, productName: "sss", count: 1, size: .m))
        
        self.loadCartItems()
    }
    
    func loadCartItems() {
        
        let itemss = Observable.just(self.data)
        
        tableView.register(CartItemTableViewCell.self, forCellReuseIdentifier: "cartCell")
     
        itemss.bind(to: self.tableView.rx.items(cellIdentifier: "cartCell", cellType: CartItemTableViewCell.self)) { row, model, cell in
            
            cell.data = model

            }.disposed(by: disposbag)
        
        
//        self.productsCollectionView!.rx
//            .modelSelected(ProductModel.self)
//            .subscribe({ value in
//
//                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController{
//
//                    vc.data = value.element
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//
//
//            })
//            .disposed(by: disposbag)
        
    }
    
    @IBAction func onCheckout(_ sender: Any) {
        
    }
    
}


//extension CartListViewController: UITableViewFlo {
//
//
//}

struct CartItem {
    
    let productId : Int
    let productName : String
    let count : Int
    let size : SizeEnum
    
}


