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
    
    var categoriesCollectionView    : UICollectionView?
    var productsCollectionView      : UICollectionView?
    
    var productCellHeight           : CGFloat {
        
        let countRows = self.productVM.products.count % 2 == 1 ? self.productVM.products.count + 1 : self.productVM.products.count
        
        return 259.0 * CGFloat( countRows / 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productVM.loadCategories()
        productVM.loadProducts()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Categories" : "Products"
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indexPath.section == 0 ? "categoryCollectionCell" : "productCollectionCell", for: indexPath)
        
        if let col = cell.viewWithTag(1) as? UICollectionView {
            
            if indexPath.section == 0 {
                self.loadCategoriesUI(collectionView: col)
            }else{
                self.loadProductsUI(collectionView: col)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 85.0 : self.productCellHeight
    }
    
    
    
    func loadCategoriesUI(collectionView : UICollectionView){
        
        self.categoriesCollectionView = collectionView
        self.categoriesCollectionView!.dataSource = nil
        
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
    
    func loadProductsUI(collectionView : UICollectionView){
        
        self.productsCollectionView = collectionView
        self.productsCollectionView!.dataSource = nil
        
        let items = Observable.just(self.productVM.products)
        
        items.bind(to: self.productsCollectionView!.rx.items(cellIdentifier: "productCell", cellType: ProductCollectionViewCell.self)) { row, model, cell in
            
            cell.data = model
            
            }.disposed(by: disposbag)
        
        
        self.productsCollectionView!.rx
            .modelSelected(ProductModel.self)
            .subscribe({ value in
                
                print(value.element?.name ?? "Empty")
                
                //if let storyboard
                self.performSegue(withIdentifier: "showDetail", sender: self)
                
            })
            .disposed(by: disposbag)
        
    }

}
