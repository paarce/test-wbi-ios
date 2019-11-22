//
//  ProductDetailViewController.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/19/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var isVisibleNavigation = true
    
    var data : ProductModel?
    
    var sizeSelected : SizeEnum?
    var colorSelected : ProductColorRGBModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.delegate = self
        //self.scrollView.contentInsetAdjustmentBehavior = .never
        self.loadUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setBackgraoundNavigation(visible: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.setBackgraoundNavigation(visible: false)
    }
    
    // MARK: - Config UI
    
    private func loadUI() {
        
        if let data = self.data {
            self.nameLabel.text = data.name
            self.priceLabel.text = "$\(data.price?.dollar ?? "$")"
            self.productImageView.image = UIImage(named: data.imageName != nil ? "product\(data.imageName!)" : "avatar" )
            
            self.loadParametersUI()
        }
        
    }
    
    
    private func setBackgraoundNavigation( visible : Bool ) {
        
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
    
    // MARK: - Buttons
    
    @IBAction func onAdd(_ sender: Any) {
        
        if let data = self.data, let colorSelected = self.colorSelected, let sizeSelected = self.sizeSelected {
            
            var aux : CartItem?
            let item = CartItem(product: data, stock: StockModel(count: 1, size: sizeSelected, color: colorSelected))
            
            ManagerRLM.sharedInstance.retieve(CartItemRLM.self, model: &aux, id: item.id)
            
            if let aux = aux {
                if aux.size == item.size {
                    item.count += aux.count
                }
            }
            
            ManagerRLM.sharedInstance.save(item)
            
            let alert = UIAlertController(title: "Added to Cart", message: "Do you want to continue shopping?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Go Cart", style: .default){ (action) in
                
                let storyboard = UIStoryboard(name: "Cart", bundle: nil)
                if  let vc = storyboard.instantiateViewController(withIdentifier: "CartListViewController") as? CartListViewController{
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
            
            alert.addAction(UIAlertAction(title: "Back List", style: .cancel) { (action) in
                self.navigationController?.popViewController(animated: false)
            })
            
            self.present(alert, animated: true)
        }
        
    }
    
    // MARK: - ScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.setBackgraoundNavigation( visible : scrollView.bounds.contains(nameLabel.frame) )
       
    }
}


extension ProductDetailViewController {
    
    
    private func loadParametersUI(){
        
        if let data = self.data {
            
            let sizeItems = Observable.just((data.stock.map{ $0.size }).removingDuplicates())
            let colorItems = Observable.just((data.stock.map{ $0.color }).removingDuplicates())
            
            self.sizeCollectionView.dataSource = nil
            sizeItems.bind(to: self.sizeCollectionView.rx.items(cellIdentifier: "sizeCell", cellType: UICollectionViewCell.self)) { row, model, cell in
                
                if let lab = cell.viewWithTag(1) as? UILabel{
                    lab.text = model.rawValue
                    lab.layer.masksToBounds = true
                    lab.layer.cornerRadius = 4
                    lab.layer.borderColor = UIColor.lightGray.cgColor
                    lab.layer.borderWidth = 1.0
                    
                    let isSelected = self.sizeSelected != nil && self.sizeSelected == model
                    
                    lab.backgroundColor = isSelected ? .darkGray : .white
                    lab.textColor = isSelected ? .white : .darkGray
                    
                }
                
                }.disposed(by: disposbag)
            
            self.sizeCollectionView.rx
                .modelSelected(SizeEnum.self)
                .subscribe({ value in
                    self.sizeSelected = value.element
                    self.addButton.isEnabled = self.colorSelected != nil && self.sizeSelected != nil 
                    self.sizeCollectionView.reloadData()
                })
                .disposed(by: disposbag)
            
            self.colorCollectionView.dataSource = nil
            colorItems.bind(to: self.colorCollectionView.rx.items(cellIdentifier: "colorCell", cellType: UICollectionViewCell.self)) { row, model, cell in
                
                if let lab = cell.viewWithTag(1) as? UILabel{
                    lab.backgroundColor = model.getColor()
                    
                    lab.layer.masksToBounds = true
                    lab.layer.cornerRadius = lab.frame.width/2
                    let isSelected = self.colorSelected != nil && self.colorSelected! == model
                    lab.layer.borderColor = isSelected ? UIColor.lightGray.cgColor : UIColor.darkGray.cgColor
                    lab.layer.borderWidth = isSelected ? 4.0 : 1.0
                }
                
                cell.selectedBackgroundView?.backgroundColor = .green
                
                }.disposed(by: disposbag)
            
            self.colorCollectionView.rx
                .modelSelected(ProductColorRGBModel.self)
                .subscribe({ value in
                    self.colorSelected = value.element
                    self.addButton.isEnabled = self.colorSelected != nil && self.sizeSelected != nil
                    self.colorCollectionView.reloadData()
                })
                .disposed(by: disposbag)
            
        }
    }
}
