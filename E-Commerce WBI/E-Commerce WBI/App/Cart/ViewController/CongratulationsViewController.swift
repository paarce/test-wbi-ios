//
//  CongratulationsViewController.swift
//  E-Commerce WBI
//
//  Created by Augusto C.P. on 11/22/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import UIKit

class CongratulationsViewController: UIViewController {

    @IBOutlet weak var codLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.clearBrackgorund()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.codLabel.text = "Cod. 00002\(Int.random(in: 1034 ..< 6666))"
    }
    
    @IBAction func onGoHome(_ sender: Any) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is ProductTableViewController {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
