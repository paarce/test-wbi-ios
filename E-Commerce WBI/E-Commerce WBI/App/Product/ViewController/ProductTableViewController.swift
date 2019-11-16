//
//  ProductTableViewController.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/13/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ProductTableViewController: UITableViewController {

    var productVM = ProductViewModel()
    
    var categoriesCollectionView : UICollectionView?
    var productsCollectionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productVM.loadCategories()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCollectionCell", for: indexPath)
        
        if let col = cell.viewWithTag(1) as? UICollectionView {
            
            self.loadCategoriesUI(collectionView: col)
        }
        
        return cell
    }
    
    
    
    func loadCategoriesUI(collectionView : UICollectionView){
        
        self.categoriesCollectionView = collectionView
        
        let items = Observable.just(self.productVM.categories)
    
        items.bind(to: self.categoriesCollectionView!.rx.items(cellIdentifier: "categoryCell", cellType: UICollectionViewCell.self)) { row, model, cell in
            
            if let avatar = cell.viewWithTag(1) as? UILabel, let name = cell.viewWithTag(2) as? UILabel {
                avatar.text = model.ini
                avatar.layer.masksToBounds = true
                avatar.layer.cornerRadius = avatar.frame.width/2
                
                name.text = model.name
            }
            
            }.disposed(by: disposbag)
    
    
        self.categoriesCollectionView!.rx
            .modelSelected(CategoryModel.self)
            .subscribe({ value in

                print(value.element?.name ?? "Empty")
            })
            .disposed(by: disposbag)
    
        
    }

}
