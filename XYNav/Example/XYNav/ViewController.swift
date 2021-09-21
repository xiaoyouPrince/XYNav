//
//  ViewController.swift
//  XYNav
//
//  Created by xiaoyouPrince on 09/15/2021.
//  Copyright (c) 2021 xiaoyouPrince. All rights reserved.
//

import UIKit
import XYInfomationSection

class ViewController: XYInfomationBaseViewController {
    
    var dataArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "RootVC"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // navigationBar 需要在此函数中才能被加载到，
        // 对 navigationBar 的设置需要放到此函数才有效
        self.navigationController?.navigationBar.isTranslucent = false
//        self.tabBarController?.tabBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.xy_getColor(hex: 0x006aff)
        
        dataArray = [
            "普通",
            "关闭侧滑返回手势",
            "全屏侧滑返回",
            "导航栏隐藏",
            "ScrollView",
            "批量setVCs, pop到指定VC",
            "TableView 自定义 NavBar",
            "自定义转场动画",
            "底部 toolbar"
        ]
        reloadUI()
    }


    @IBAction func push(_ sender: Any) {
        
        let contVC = YellowViewController()
        contVC.xy_isPopGestureEnable = false
        self.navigationController?.pushViewController(contVC, animated: true)
    }
    
    
    @IBAction func push2(_ sender: Any) {
        
        let contVC = GreenViewController()
        contVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(contVC, animated: true)
    }
    
    func push3(_ sender: Any) {
        
        let contVC = RedViewController()
        contVC.hidesBottomBarWhenPushed = true
        contVC.xy_popGestureRatio = 1
        self.navigationController?.pushViewController(contVC, animated: true)
    }
    
    @IBAction func push4(_ sender: Any) {
        
        let contVC = GreenViewController()
        contVC.hideNavBar = true
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

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func reloadUI() {
        let tableView = UITableView(frame: self.view.bounds)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = dataArray[indexPath.row]
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            push2(0)
        }
        
        if indexPath.row == 1 {
            push(0)
        }
        
        if indexPath.row == 2 {
            push3(0)
        }
        
        if indexPath.row == 3 {
            push4(0)
        }
        
        if indexPath.row == 4 {
            let detail = ScrollViewController()
            detail.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detail, animated: true)
        }
        
        if indexPath.row == 5 {
            setControllers(0)
        }
        
        if indexPath.row == 6 {
            let detail = TableViewController()
            detail.hidesBottomBarWhenPushed = true
            detail.xy_customNavBarClass = CusNavBar.self
            self.navigationController?.pushViewController(detail, animated: true)
        }
        
        if indexPath.row == 7 {
            let detail = TableViewController()
            detail.hidesBottomBarWhenPushed = true
            detail.xy_customNavBarClass = CusNavBar.self
            detail.customTransion = true
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
}


