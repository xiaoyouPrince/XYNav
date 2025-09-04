//
//  DestViewController.swift
//  XYNav
//
//  Created by xy on 2021/9/14.
//

import UIKit

class GreenViewController: BaseViewController {
    
    var hideNavBar = false
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        if #available(iOS 13.0, *) {
//            return UIStatusBarStyle.darkContent
//        } else {
//            // Fallback on earlier versions
//            return UIStatusBarStyle.default
//        }
//    }
//    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //        UIApplication.shared.setStatusBarHidden(true, with: .fade)
//        UIApplication.shared.isStatusBarHidden = true
        
        if #available(iOS 13.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            for scene in scenes {
                if let wins = scene as? UIWindowScene {
                    let frame = wins.statusBarManager?.statusBarFrame ?? .zero
                    let hidden = wins.statusBarManager?.isStatusBarHidden ?? true
                    let style = wins.statusBarManager?.statusBarStyle ?? .lightContent
                    print("\(frame)\n\(hidden)\n\(style)")
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .green
        self.title = "green"
        
        if #available(iOS 14.0, *) {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(back))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "nav 栈", style: .plain, target: self, action: #selector(navStack))
        } else {
            // Fallback on earlier versions
        }
        
        self.navigationItem.leftBarButtonItems = [
            UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(back)),
            UIBarButtonItem.init(title: "nav 栈", style: .plain, target: self, action: #selector(navStack))
        ]
        for item in self.navigationItem.leftBarButtonItems! {
            item.tintColor = UIColor.red
        }
        
        self.navigationController?.navigationBar.isHidden = hideNavBar
        
        let btn = UIButton()
        self.view.addSubview(btn)
        btn.setTitle("去新页面", for: .normal)
        btn.frame = CGRect(x: 100, y: 200, width: 200, height: 40)
        btn.addTarget(self, action: #selector(gotoNewPage), for: .touchUpInside)
        
//        self.navigationController?.navigationBar.isOpaque = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nav_titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 35), .foregroundColor: UIColor.red]
        nav_setBarTintColor(color: .green)

        xy_isContentPopGestureEnable = false
    }
    
    @objc
    func back() {
        let popVC = self.navigationController?.popViewController(animated: true)
        popVC?.view.backgroundColor = .red
    }
    @objc
    func navStack() {
        print(self.navigationController?.viewControllers)
    }
    
    @objc
    func gotoNewPage() {
        let detail = YellowViewController()
//        detail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detail, animated: true)
        
        if self.navigationController == nil {
            //self.presentingViewController 是 tabbarVC， 不能同时present多个
//            self.presentingViewController?.present(detail, animated: true, completion: nil)
            self.present(detail, animated: true, completion: nil)
        }
    }
}
