//
//  XYNavigationController.swift
//  XYNav
//
//  Created by xy on 2021/9/14.
//

import UIKit

func warpNewPushVC(_ desVC: UIViewController, _ superNav: XYNavigationController) -> UIViewController {
    if desVC is XYContentController { return desVC }
    
    let contVC = XYContentController()
    let nav = XYContentNavController(rootViewController: desVC)
    nav.superNav = superNav
    contVC.addChild(nav)
    contVC.view.addSubview(nav.view)
    contVC.contentVc = desVC
    contVC.contentNav = nav
    contVC.hidesBottomBarWhenPushed = desVC.hidesBottomBarWhenPushed
    return contVC
}

func warpVC(_ desVC: UIViewController, _ superNav: XYNavigationController, isRootVC: Bool) -> UIViewController {
    let newVC = warpNewPushVC(desVC, superNav)
    if isRootVC{
        return newVC
    }else{
        newVC.hidesBottomBarWhenPushed = true
        desVC.navigationItem.leftBarButtonItem = UIBarButtonItem(image: getBackImage(), style: .plain, target: superNav, action: #selector(XYNavigationController.popViewController(animated:)))
        return newVC
    }
}

func unWarpNewPushVC(_ desVC: UIViewController) -> UIViewController {
    if desVC is XYContentController, let contentVC = desVC as? XYContentController {
        return contentVC.contentVc ?? desVC
    }
    return desVC
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
        self.setViewControllers([newVC], animated: false)
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
        
//        if viewControllers.count == 0 { return }
//        if viewControllers.count == 1 {
//            super.setViewControllers([], animated: false)
//            self.pushViewController(viewControllers.first!, animated: animated)
//        }else{
//            super.setViewControllers([], animated: false)
//            let prefixVCs = viewControllers.prefix(viewControllers.count - 1)
//            for prefixVC in prefixVCs {
//                self.pushViewController(prefixVC, animated: false)
//            }
//            self.pushViewController(viewControllers.last!, animated: animated)
//        }
        var warpedVCs: [UIViewController] = []
        for vc in viewControllers {
            warpedVCs.append(warpVC(vc, self, isRootVC: viewControllers.first == vc))
        }
        super.setViewControllers(warpedVCs, animated: animated)
    }
    
    open override var viewControllers: [UIViewController]{
        
        set{
            var warpedVCs: [UIViewController] = []
            for vc in newValue {
                warpedVCs.append(warpVC(vc, self, isRootVC: viewControllers.first == vc))
            }
            super.viewControllers = warpedVCs
        }
        
        get{
            var resultVCs: [UIViewController] = []
            let warpedVCs = super.viewControllers
            for warpedVC in warpedVCs {
                resultVCs.append(unWarpNewPushVC(warpedVC))
            }
            return resultVCs
        }
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
