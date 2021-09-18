//
//  XYNavigationController.swift
//  XYNav
//
//  Created by xy on 2021/9/14.
//

import UIKit

func warpNewPushVC(_ desVC: UIViewController, _ superNav: XYNavigationController) -> UIViewController {
    let contVC = UIViewController()
    contVC.hidesBottomBarWhenPushed = desVC.hidesBottomBarWhenPushed
    
    let nav = XYContentNavController(rootViewController: desVC)
    nav.superNav = superNav
    contVC.addChild(nav)
    contVC.view.addSubview(nav.view)
    
    return contVC
}

var backImage: UIImage? = nil
func getBackImage() -> UIImage {
    
    if backImage != nil {
        return backImage!
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 44, height: 44), false, 0.0)
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 15, y: 10))
    path.addLine(to: CGPoint(x: 2, y: 22))
    path.addLine(to: CGPoint(x: 15, y: 34))
    path.lineWidth = 2.5
    path.lineCapStyle = .round
    path.lineJoinStyle = .bevel
    
    UIColor.red.set()
    path.stroke()
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    backImage = image
    return image ?? UIImage()
}

open
class XYNavigationController: UINavigationController {
    
    // MARK: - open vars
    
    
    

    // MARK: - life circle
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        


        
        // 直接调用 nav 的方法，会直接隐藏 navigationBar 且同时干掉侧滑返回功能
//        isNavigationBarHidden = true
//        setNavigationBarHidden(true, animated: false)
//        setNavigationBarHidden(true, animated: true)
        
        // 直接拿到navigationBar本身，设置它自己的 hidden，
        navigationBar.isHidden = true
    }
    
    // MARK: - 初始化
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        let newVC = warpNewPushVC(rootViewController, self)
        self.setViewControllers([newVC], animated: true)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let rootVC = self.viewControllers.first else {
            return
        }
        
        let newVC = warpNewPushVC(rootVC, self)
        self.setViewControllers([newVC], animated: false)
    }
    
    // MARK: - push & pop
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let newVC = warpNewPushVC(viewController, self)
        if viewControllers.count > 0 {
            newVC.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: getBackImage(), style: .plain, target: self, action: #selector(popViewController(animated:)))
        }
        super.pushViewController(newVC, animated: animated)
    }
    
    // MARK: - setViewControllers
    open override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        var newVCs: [UIViewController] = []
        for vc in viewControllers {
            let newVC = warpNewPushVC(vc, self)
            newVCs.append(newVC)
        }
        super.setViewControllers(newVCs, animated: animated)
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
