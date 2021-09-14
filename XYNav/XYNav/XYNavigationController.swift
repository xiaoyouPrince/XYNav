//
//  XYNavigationController.swift
//  XYNav
//
//  Created by xy on 2021/9/14.
//

import UIKit

func warpNewPushVC(_ desVC: UIViewController, _ superNav: XYNavigationController) -> UIViewController {
    let contVC = UIViewController()
    
    let nav = XYContentNavController(rootViewController: desVC)
    nav.superNav = superNav
    contVC.addChild(nav)
    contVC.view.addSubview(nav.view)
    
    return contVC
}

class XYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        


        
        // 直接调用 nav 的方法，会直接隐藏 navigationBar 且同时干掉侧滑返回功能
//        isNavigationBarHidden = true
//        setNavigationBarHidden(true, animated: false)
//        setNavigationBarHidden(true, animated: true)
        
        // 直接拿到navigationBar本身，设置它自己的 hidden，
        navigationBar.isHidden = true
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let rootVC = self.viewControllers.first else {
            return
        }
        
        let newVC = warpNewPushVC(rootVC, self)
        self.setViewControllers([newVC], animated: true)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let newVC = warpNewPushVC(viewController, self)
        super.pushViewController(newVC, animated: animated)
    }

}


extension UIViewController {
    
    
    
//    func navigationController() -> UINavigationController? {
//        if self.navigationController is XYContentNavController {
//            self.navigationController?
//        }else{
//            return self.navigationController
//        }
//
//        return nil
//    }
    
}
