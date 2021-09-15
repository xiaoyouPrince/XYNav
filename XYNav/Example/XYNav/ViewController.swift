//
//  ViewController.swift
//  XYNav
//
//  Created by xiaoyouPrince on 09/15/2021.
//  Copyright (c) 2021 xiaoyouPrince. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func push(_ sender: Any) {
        
        let contVC = UIViewController()
        contVC.view.backgroundColor = .yellow
        self.navigationController?.pushViewController(contVC, animated: true)
    }
    
    
    @IBAction func push2(_ sender: Any) {
        
        let contVC = DestViewController()
        self.navigationController?.pushViewController(contVC, animated: true)
    }
}


