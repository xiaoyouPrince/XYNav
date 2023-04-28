//
//  ThirdViewController.swift
//  XYNav_Example
//
//  Created by 渠晓友 on 2021/9/17.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class RedViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        self.title = "red"
        
        if #available(iOS 14.0, *) {
//            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(back))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "nav 栈", style: .plain, target: self, action: #selector(navStack))
        } else {
            // Fallback on earlier versions
        }
        
        let btn = UIButton()
        self.view.addSubview(btn)
        btn.setTitle("去新页面", for: .normal)
        btn.frame = CGRect(x: 100, y: 200, width: 200, height: 40)
        btn.addTarget(self, action: #selector(gotoNewPage), for: .touchUpInside)
        
        let btn2 = UIButton()
        self.view.addSubview(btn2)
        btn2.setTitle("pop 到第二个VC", for: .normal)
        btn2.frame = CGRect(x: 100, y: 300, width: 200, height: 40)
        btn2.addTarget(self, action: #selector(popTo), for: .touchUpInside)
        
        let btn3 = UIButton()
        self.view.addSubview(btn3)
        btn3.setTitle("pop 到 rootVC", for: .normal)
        btn3.frame = CGRect(x: 100, y: 400, width: 200, height: 40)
        btn3.addTarget(self, action: #selector(popToRoot), for: .touchUpInside)
        
        let btn4 = UIButton()
        self.view.addSubview(btn4)
        btn4.setTitle("presentVC 并打印当前的topVC,visibleVC", for: .normal)
        btn4.frame = CGRect(x: 30, y: 500, width: 360, height: 80)
        btn4.addTarget(self, action: #selector(presentAndPrint), for: .touchUpInside)
        
//        self.navigationController?.navigationBar.isOpaque = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = .red
        self.navigationController?.navigationBar.tintColor = .yellow
    }
    
    @objc
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc
    func navStack() {
        print(self.navigationController?.viewControllers)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_risk_tip_close"), style: .plain, target: self, action: #selector(back))
        
//        self.navigationController?.navigationBar.barTintColor = .yellow
    }
    
    @objc
    func gotoNewPage() {
        let detail = RedViewController()
//        detail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    @objc
    func popTo() {
        let currentVCs = self.navigationController?.viewControllers
        if currentVCs?.count ?? 0 > 1 {
            let popedVCs = self.navigationController?.popToViewController(currentVCs![1], animated: true)
            print("popedVCs","=",popedVCs)
        }
    }
    
    @objc
    func popToRoot() {
        let currentVCs = self.navigationController?.viewControllers
        if currentVCs?.count ?? 0 > 0 {
            let popedVCs = self.navigationController?.popToRootViewController(animated: true)
            print("popedVCs","=",popedVCs)
        }
    }
    
    @objc
    func presentAndPrint() {
        self.present(GreenViewController(), animated: true) {
            print("present 新 VC 完成")
            print("当期topVC = ", self.navigationController?.topViewController)
            print("当期visiableVC = ", self.navigationController?.visibleViewController)
        }
    }

}
