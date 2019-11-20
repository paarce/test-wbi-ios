//
//  array+extension.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/20/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
