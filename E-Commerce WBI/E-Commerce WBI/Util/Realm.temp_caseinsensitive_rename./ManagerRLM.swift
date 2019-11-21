//
//  ManagerRLM.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/21/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation
import RealmSwift

public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

class ManagerRLM {
    
    static let sharedInstance = ManagerRLM()
    fileprivate let container = try! Container()
    private init() {
    }
    
    func setDefaultRealmForUser(username: String) {
        var version = 1
        if let path = Bundle.main.path(forResource: "Supporting Files/Info", ofType: "plist"),  let info = NSDictionary(contentsOfFile: path) {
            if let ver = info["RealmDataBaseVersion"] as? String {
                version = Int(ver)!
            }
        }
        var config = Realm.Configuration()
        
        // Use the default directory, but replace the filename with the username
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(username)_ver_\(version).realm")
        
        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
    func save<T: Persistable>(_ data : T) {
        try! container.action({ (trans) in
            trans.add(data, update: true)
        })
    }
    
    func saveList<T: Persistable>(_ data : [T]) {
        for classs in data {
            try! container.action({ (trans) in
                trans.add(classs, update: true)
            })
        }
    }
    
    func retieve<T: RealmSwift.Object , Q : Persistable>(_ type: T.Type , model : inout Q?, id : String ){
        try! container.action { (trans) in
            let l = trans.retrieve(type)
            let list = l.filter("id = '\(id)'")
            if list.count == 1 {
                model = Q.init(managedObject: list[0] as! Q.ManagedObject)
            }
            
        }
    }
    
    func retieveList<T: RealmSwift.Object , Q : Persistable>(_ type: T.Type , model : inout [Q] , param : String? = nil , param_value : String? = nil ){
        try! container.action { (trans) in
            var list = trans.retrieve(type)
            var arr : [Q] = []
            if let id = param_value {
                list = list.filter("\(param ?? "id" ) = \(id)")
            }
            for item in list {
                arr.append( Q.init(managedObject: item as! Q.ManagedObject) )
            }
            
            model = arr
            
        }
    }
    
    func remove<T: RealmSwift.Object>(_ type: T.Type ,id : String) {
        
        try! container.action { (trans) in
            
            let list = trans.retrieve(type)
            if let item = list.filter("id = '\(id)'").first {
                trans.remove(item)
            }
        }
    }
    
    
}

fileprivate final class TransactionRLM {
    private let realm: Realm
    internal init(realm: Realm) {
        self.realm = realm
    }
    
    public func add<T: Persistable>(_ value: T, update: Bool) {
        
        realm.add(value.managedObject(), update: .all)
    }
    
    public func retrieve<T: Object>(_ type: T.Type) -> Results<T> {
        return realm.objects(type)
    }
    
    public func remove<T: Object>(_ item: T){
        realm.delete(item)
    }
    
}

// Implement the Container
fileprivate final class Container {
    
    private let realm: Realm
    
    public convenience init() throws {
        try self.init(realm: Realm())
    }
    
    internal init(realm: Realm) {
        self.realm = realm
    }
    
    public func action(_ block: (TransactionRLM) throws -> Void)
        throws {
            let transaction = TransactionRLM(realm: realm)
            try realm.write {
                try block(transaction)
            }
    }
}
