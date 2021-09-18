//
//  SecordViewController.swift
//  XYNav_Example
//
//  Created by 渠晓友 on 2021/9/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class YellowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .yellow
        self.title = "yellow"
    
        if #available(iOS 14.0, *) {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(back))
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = .yellow
    }
    
    @objc
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    

    

}
