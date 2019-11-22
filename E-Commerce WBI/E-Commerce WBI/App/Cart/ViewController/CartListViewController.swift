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
import Toast_Swift

class CartListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var data : [CartItem] = []
    var isDataLoaded = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 128
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.loadCartItems()
        self.calculateTotal()
    }
    
    
    private func loadCartItems() {
        
        ManagerRLM.sharedInstance.retieveList(CartItemRLM.self, model: &self.data)
        self.isDataLoaded = true
        
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
        cell?.parent = self
        
        return cell!
    }
    
    override func willMove(toParent parent: UIViewController?) {
    
        if self.isDataLoaded {
            ManagerRLM.sharedInstance.saveList(self.data)
        }
    }
    
    @IBAction func onCheckout(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "About to checkout", message: "Please select your peyment method", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Paypal", style: .default){ (action) in
            
            self.showCongratulations()
        })
        alert.addAction(UIAlertAction(title: "Credit card", style: .default){ (action) in
            
            self.showCongratulations()
        })
        alert.addAction(UIAlertAction(title: "Debit card", style: .default){ (action) in
            
            self.showCongratulations()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        })
        
        self.present(alert, animated: true)
    }
    
    func showCongratulations() {
        
        self.view.makeToastActivity(.center)
        
        for item in self.data {
            ManagerRLM.sharedInstance.remove(CartItemRLM.self, id: item.id)
        }
        self.view.hideToast()
        
        self.performSegue(withIdentifier: "showCongratulations", sender: nil)
    }
    
    func calculateTotal() {
        var total : Float = 0.0
        for item in self.data {
            total += (item.price * Float(item.count))
        }
        
        self.totalPriceLabel.text = "$\(total.dollar)"
    }
    
}
