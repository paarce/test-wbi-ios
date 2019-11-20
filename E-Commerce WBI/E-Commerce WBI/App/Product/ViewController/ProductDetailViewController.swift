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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var priceLabel: UILabel!
    
    var isVisibleNavigation = true
    
    var data : ProductModel?
    
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
            
            self.loadParametersUI()
        }
        
    }
    
    
    private func loadParametersUI(){
        
        if let data = self.data {
            
            let sizeItems = Observable.just((data.stock.map{ $0.size }).removingDuplicates())
            let colorItems = Observable.just((data.stock.map{ $0.color }))
            
            self.sizeCollectionView.dataSource = nil
            sizeItems.bind(to: self.sizeCollectionView.rx.items(cellIdentifier: "sizeCell", cellType: UICollectionViewCell.self)) { row, model, cell in
                
                if let lab = cell.viewWithTag(1) as? UILabel{
                    lab.text = model.rawValue
                    lab.layer.masksToBounds = true
                    lab.layer.cornerRadius = 4
                }
                
                cell.selectedBackgroundView?.backgroundColor = .green
                
                }.disposed(by: disposbag)
            
            self.colorCollectionView.dataSource = nil
            colorItems.bind(to: self.colorCollectionView.rx.items(cellIdentifier: "colorCell", cellType: UICollectionViewCell.self)) { row, model, cell in
                
                if let lab = cell.viewWithTag(1) as? UILabel{
                    lab.backgroundColor = model.getColor()
                    
                    lab.layer.masksToBounds = true
                    lab.layer.cornerRadius = lab.frame.width/2
                }
                
                cell.selectedBackgroundView?.backgroundColor = .green
                
                }.disposed(by: disposbag)
            
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
    }
    
    // MARK: - ScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.setBackgraoundNavigation( visible : scrollView.bounds.contains(nameLabel.frame) )
       
    }
    
    

}
