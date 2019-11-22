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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.defaultBrackgorund()
    }
    
    private func loadCartItems() {
        
        ManagerRLM.sharedInstance.retieveList(CartItemRLM.self, model: &self.data)
        self.isDataLoaded = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.data.count == 0 {
            self.tableView.setEmptyView(title: "Cart empty.", message: "Here you will see your products added")
        }
        else {
            self.tableView.restore()
        }
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
            
            let ceroItems = self.data.filter { $0.count == 0 }
            
            for item in ceroItems {
                ManagerRLM.sharedInstance.remove(CartItemRLM.self, id: item.id)
            }
            
            ManagerRLM.sharedInstance.saveList(self.data.filter { $0.count > 0 })
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
