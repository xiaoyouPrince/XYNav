//
//  BaseViewController.swift
//  XYNav_Example
//
//  Created by 渠晓友 on 2021/9/19.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    deinit {
        print("\(String(describing: self.description.components(separatedBy: ".").last))"+"-deinit-")
    }
}
