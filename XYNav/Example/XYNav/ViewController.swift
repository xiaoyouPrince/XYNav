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
        self.navigationController?.navigationBar.isTranslucent = false
    }


    @IBAction func push(_ sender: Any) {
        
        let contVC = YellowViewController()
        self.navigationController?.pushViewController(contVC, animated: true)
    }
    
    
    @IBAction func push2(_ sender: Any) {
        
        let contVC = GreenViewController()
        contVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(contVC, animated: true)
    }
    
    @IBAction func setControllers(_ sender: Any) {
        
        let contVC1 = YellowViewController()
        let contVC2 = GreenViewController()
        let contVC3 = RedViewController()
        self.navigationController?.viewControllers = [self,contVC1,contVC2,contVC3]
        
        // self.navigationController?.setViewControllers([self,contVC,contVC1,contVC2,contVC3], animated: true)
    }
    
    
    @IBAction func getControllers(_ sender: Any) {
        print(self.navigationController?.viewControllers)
    }
}


