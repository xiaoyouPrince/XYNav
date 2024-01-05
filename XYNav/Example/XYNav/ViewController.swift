//
//  ViewController.swift
//  XYNav
//
//  Created by xiaoyouPrince on 09/15/2021.
//  Copyright (c) 2021 xiaoyouPrince. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: BaseViewController {
    
    static var time = 0
    
    @objc func pageCode() -> String{
        return "10"
    }
    
    var dataArray: [String] = []
    var tableView = UITableView(frame: .zero, style: .plain)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var a = [1,2,3,4,5]
        a.replaceSubrange(1...1, with: [5])
        print("a ------ \(a)")
        
        
        
        // Do any additional setup after loading the view.
        if self.responds(to: Selector(stringLiteral: "pageCode")) {
            let code = self.perform(Selector(stringLiteral: "pageCode"))
//            if let aa = code as? Int{
//                print("code = \(aa)")
//            }
            
            print(type(of: code))
            
            if let theCode = code?.takeRetainedValue() as? String {
                print(theCode)
            }
            
        }
        
        let code: Int? = 10
        if code == 10 {
            print("code == 10")
        }
        
        if code != nil, code != 5 {
            print("code 非空且 != 5")
        }
        
        if code != nil && code != 5 {
            print("code 非空且 != 5")
        }
        
//        print(self.self) // 打印对象
//        print(type(of: self)) // 打印对象的类型
        
        if ViewController.time >= 1 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
        ViewController.time += 1
        
        if #available(iOS 15.0, *) {
            let app = UITabBarAppearance()
            app.selectionIndicatorTintColor = .red
            tabBarController?.tabBar.scrollEdgeAppearance = app
        } else {
            // Fallback on earlier versions
        }
        
        let index = tabBarController?.selectedIndex ?? 0
        self.title = "RootVC - \(index)"
        self.view.addSubview(tableView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // navigationBar 需要在此函数中才能被加载到，
        // 对 navigationBar 的设置需要放到此函数才有效
        self.navigationController?.navigationBar.isTranslucent = false
//        self.tabBarController?.tabBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.xy_getColor(hex: 0x006aff)
        
        // tabbar 透明
        tabBarController?.tabBar.isTranslucent = true
        
        if #available(iOS 15.0, *) {
            let app = UITabBarAppearance()
            app.backgroundColor = .clear
            tabBarController?.tabBar.scrollEdgeAppearance = app
        } else {
            // Fallback on earlier versions
        }
        
        dataArray = [
            "普通",
            "关闭侧滑返回手势",
            "全屏侧滑返回",
            "导航栏隐藏",
            "ScrollView",
            "批量setVCs, pop到指定VC",
            "TableView 自定义 NavBar",
            "自定义转场动画",
            "底部 toolbar",
            "SwiftUI - UIKit",
            "placeholder",
            "placeholder",
            "placeholder",
            "placeholder",
            "placeholder",
            "placeholder",
            "placeholder",
            "placeholder",
            "placeholder",
            "placeholder",
            "placeholder",
            "placeholder",
            "placeholder"
            
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
    
    
    /// swiftUI 和 UIKit 混合使用
    func swiftUITest() {
        if #available(iOS 13.0, *) {
            let ui =  UIHostingController(rootView: body)
            ui.title = "UIKit Push SwiftUI"
            nav_push(ui, animated: true)
        } else {
            // Fallback on earlier versions
            print("此方法仅在 iOS 13 以上生效")
        }
    }
    
    @available(iOS 13.0, *)
    @ViewBuilder
    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage:.add )
            
            Text("探索图片加载过程")
            Text("1. 主工程解压 zip 到沙盒")
            Text("2. 主工程写入信息到 AppGroup")
            Text("3. 拓展,读数据, 渲染")
//                .swingAnimation(duration: 2, direction: .horizontal, distance: 30)
        }
        .padding()
        .onAppear {
            print("is on Appear")
        }
//        .swingAnimation(duration: 2, direction: .horizontal, distance: 30)
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func reloadUI() {
        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = self.view.bounds
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
//            detail.xy_customNavBarClass = CusNavBar.self
            detail.title = "你好"
            detail.customTransion = true
            self.navigationController?.pushViewController(detail, animated: true)
        }
        
        if indexPath.row == 8 {
            let detail = WebViewController()
            detail.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detail, animated: true)
        }
        
        if indexPath.row == 9 {
            swiftUITest()
        }
    }
}


