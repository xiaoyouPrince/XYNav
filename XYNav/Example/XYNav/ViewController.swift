//
//  ViewController.swift
//  XYNav
//
//  Created by xiaoyouPrince on 09/15/2021.
//  Copyright (c) 2021 xiaoyouPrince. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // navigationBar 需要在此函数中才能被加载到，
        // 对 navigationBar 的设置需要放到此函数才有效
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
//        self.navigationController?.viewControllers = [self,contVC1,contVC2,contVC3]
         self.navigationController?.setViewControllers([self,contVC1,contVC2,contVC3], animated: true)
    }
    
    
    @IBAction func getControllers(_ sender: Any) {
        print(self.navigationController?.viewControllers)
    }
}


