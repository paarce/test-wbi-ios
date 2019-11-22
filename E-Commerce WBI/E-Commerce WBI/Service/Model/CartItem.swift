//
//  CartItemRLM.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/21/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation
import RealmSwift


/// Struct to encapsulate the "Interval" data from json

class CartItem : Persistable {
    
    typealias ManagedObject = CartItemRLM
    
    let id : String
    let productName : String
    let productImage : String
    var count : Int
    let price : Float
    var size : SizeEnum
    var color : ProductColorRGBModel
    
    init(product : ProductModel, stock : StockModel) {
        
        self.id = "\(product.id)@\(stock.size.rawValue)@\(stock.color.description)"
        self.productName = product.name ?? ""
        self.productImage = product.imageName ?? ""
        self.price = product.price ?? 0.0
        self.count = stock.count
        self.size = stock.size
        self.color = stock.color
    }
    
    required public init(managedObject: ManagedObject) {
        
        id = managedObject.id
        productName = managedObject.productName
        productImage = managedObject.productImage
        count = managedObject.count
        price = managedObject.price
        size = .s
        
        for sizeAux in SizeEnum.allCases {
            if sizeAux.rawValue == managedObject.size {
                size = sizeAux
            }
        }
        
        var sR : Float = 255.0, sG  : Float  = 255.0, sB : Float  = 255.0
        
        let colorData = managedObject.color.components(separatedBy: "/")
        if colorData.count == 3 {
            if let r = Float(colorData[0]), let g = Float(colorData[1]), let b = Float(colorData[2]) {
                sR = r; sG = g; sB = b
            }
        }
        
        color = ProductColorRGBModel(r: sR, g: sG, b: sB)
    }
    
    public func managedObject() -> ManagedObject {
        let object = ManagedObject()
        
        object.id = id
        object.productName = productName
        object.productImage = productImage
        object.count = count
        object.price = price
        object.size = size.rawValue
        object.color = "\(color.r)/\(color.g)/\(color.b)"
        
        return object
    }
    
}

class CartItemRLM :  Object {
    
    @objc dynamic var id : String = ""
    @objc dynamic var productName : String = ""
    @objc dynamic var productImage : String = ""
    @objc dynamic var count : Int = 0
    @objc dynamic var price : Float = 0.0
    @objc dynamic var size : String = ""
    @objc dynamic var color : String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
