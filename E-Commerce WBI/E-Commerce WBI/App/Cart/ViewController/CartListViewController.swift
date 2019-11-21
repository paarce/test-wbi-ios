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

class CartListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var data : [CartItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 128
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.loadCartItems()
    }
    
    
    func loadCartItems() {
        
        ManagerRLM.sharedInstance.retieveList(CartItemRLM.self, model: &self.data)
        
//        let itemss = Observable.just(self.data)
//        tableView.delegate = self
//        tableView.register(CartItemTableViewCell.self, forCellReuseIdentifier: "cartCell")
//
//        itemss.bind(to: self.tableView.rx.items(cellIdentifier: "cartCell", cellType: CartItemTableViewCell.self)) { row, model, cell in
//
//            cell.data = model
//
//            }.disposed(by: disposbag)
//
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as? CartItemTableViewCell
        
        cell?.data = data[indexPath.row]
        
        return cell!
    }
    
    @IBAction func onCheckout(_ sender: Any) {
        
    }
    
}
