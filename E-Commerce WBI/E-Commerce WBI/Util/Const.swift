//
//  Const.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/16/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation
import RxSwift

let deviceUID = UIDevice.current.identifierForVendor!.uuidString
let disposbag = DisposeBag()
let defaults = UserDefaults.standard


let  regexEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
