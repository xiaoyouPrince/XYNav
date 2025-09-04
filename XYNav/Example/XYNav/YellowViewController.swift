//
//  SecordViewController.swift
//  XYNav_Example
//
//  Created by 渠晓友 on 2021/9/16.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class YellowViewController: BaseViewController {
    
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .yellow
        self.title = "yellow"
    
        if #available(iOS 14.0, *) {
//            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(back))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "nav 栈", style: .plain, target: self, action: #selector(navStack))
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 10.0, *) {
            timer = Timer(timeInterval: 1, repeats: true) { (timer) in
                print("yello - 我还活着呢")
                print("self.presentingViewController = \(self.parent?.parent)")
                print("self.presentingViewController2 = \(self.presentingViewController?.presentingViewController)")
                print("self.presentingViewController3 = \(self.presentingViewController?.presentingViewController?.presentingViewController)")
                print("self.presentingViewController4 = \(self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController)")
                print("------------------")
            }
            RunLoop.current.add(timer!, forMode: .common)
            timer?.fire()
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = .yellow
        self.xy_isPopGestureEnable = false
        
        self.xy_isContentPopGestureEnable = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print(self, "viewWillDisappear")
        timer?.invalidate()
        print(self, "viewWillDisappear -- 完成")
    }
    
    @objc
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func navStack() {
        print(self.navigationController?.viewControllers)
    }

    

}
