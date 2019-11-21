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
    
    var categorySelected = -1
    
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
        return indexPath.section == 0 ? 85.0 : self.productVM.productEntireCellHeight
    }
    
    
    private func loadCategoriesUI(collectionView : UICollectionView){
        
        self.categoriesCollectionView = collectionView
        self.categoriesCollectionView!.dataSource = nil
        
        let items = Observable.just(self.productVM.categories)
    
        items.bind(to: self.categoriesCollectionView!.rx.items(cellIdentifier: "categoryCell", cellType: UICollectionViewCell.self)) { row, model, cell in
            
            if let avatar = cell.viewWithTag(1) as? UILabel, let name = cell.viewWithTag(2) as? UILabel {
                avatar.layer.masksToBounds = true
                avatar.layer.cornerRadius = avatar.frame.width/2
                avatar.text = model.ini
                avatar.backgroundColor = self.categorySelected == model.id ? .darkGray : .greenEco
                
                name.text = model.name
            }
            
            }.disposed(by: disposbag)
    
        
    
        self.categoriesCollectionView!.rx
            .modelSelected(CategoryModel.self)
            .subscribe({ value in
                self.categorySelected = value.element?.id ?? -1
                self.categoriesCollectionView!.reloadData()
                self.reloadProducts()
            })
            .disposed(by: disposbag)
        
    }
    
    private func loadProductsUI(collectionView : UICollectionView){
        
        self.productsCollectionView = collectionView
        self.productsCollectionView!.dataSource = nil
        
        self.productVM.products.bind(to: self.productsCollectionView!.rx.items(cellIdentifier: "productCell", cellType: ProductCollectionViewCell.self)) { row, model, cell in
            
            cell.data = model
            
            }.disposed(by: disposbag)
        
        
        self.productsCollectionView!.rx
            .modelSelected(ProductModel.self)
            .subscribe({ value in
                
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController{
                   
                    vc.data = value.element
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
            .disposed(by: disposbag)
        
        self.productsCollectionView!.rx
            .setDelegate(self)
            .disposed(by: disposbag)
        
    }
    
    func reloadProducts() {
        
        let filter = self.categorySelected == -1 ? self.productVM.allProducts : self.productVM.allProducts.filter { $0.category.id == self.categorySelected }
       
        self.productVM.products.accept( filter )
    }
    
    // MARK: - Buttons
    
    @IBAction func onCart(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Cart", bundle: nil)
        if  let vc = storyboard.instantiateViewController(withIdentifier: "CartListViewController") as? CartListViewController{
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to leave?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Log Out", style: .default){ (action) in
            
//            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
//            if  let vc = storyboard.instantiateInitialViewController(){
//
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
            
            self.performSegue(withIdentifier: "showAuth", sender: self)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.navigationController?.popViewController(animated: false)
        })
        
        self.present(alert, animated: true)
        
    }
    
}

extension ProductTableViewController : UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.size.width / self.productVM.countItemInRow) - 10.0 , height: self.productVM.productCellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}
