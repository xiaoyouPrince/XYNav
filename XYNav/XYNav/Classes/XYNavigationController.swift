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
    let nav = XYContentNavController(navigationBarClass: desVC.xy_customNavBarClass, toolbarClass: nil)
    nav.pushViewController(desVC, animated: false)
    nav.superNav = superNav
    contVC.addChild(nav)
    contVC.view.addSubview(nav.view)
    contVC.contentVc = desVC
    contVC.contentNav = nav
    contVC.hidesBottomBarWhenPushed = desVC.hidesBottomBarWhenPushed
    superNav.panGesture?.isEnabled = desVC.xy_isPopGestureEnable
    return contVC
}

func warpVC(_ desVC: UIViewController, _ superNav: XYNavigationController, isRootVC: Bool) -> UIViewController {
    let newVC = warpNewPushVC(desVC, superNav)
    if isRootVC{
        return newVC
    }else{
        newVC.hidesBottomBarWhenPushed = true
        desVC.navigationItem.leftBarButtonItem = UIBarButtonItem(image: getBackImage(), style: .plain, target: superNav, action: #selector(XYNavigationController.popByDefaultAction))
        return newVC
    }
}

func unWarpNewPushVC(_ desVC: UIViewController, needResign: Bool) -> UIViewController {
    if desVC is XYContentController, let contentVC = desVC as? XYContentController {
        let resultVC = contentVC.contentVc
        if needResign {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                contentVC.removeFromParent()
            }
        }
        return resultVC ?? desVC
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
    var panGesture: UIPanGestureRecognizer?
    
    // MARK: - life circle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        super.interactivePopGestureRecognizer?.isEnabled = false
        panGesture = UIPanGestureRecognizer(target: super.interactivePopGestureRecognizer?.delegate, action: Selector(("handleNavigationTransition:")))
        panGesture!.delegate = self
        view.addGestureRecognizer(panGesture!)
        
        navigationBar.isHidden = true
    }
    
    // MARK: - 初始化
    public override init(rootViewController: UIViewController) {
        // this method will call pushVC internal
        super.init(rootViewController: rootViewController)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let rootVC = self.viewControllers.first else {
            return
        }
        setViewControllers([rootVC], animated: false)
    }
    
    // MARK: - push & pop
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        var currentVCs = viewControllers
        currentVCs.append(viewController)
        setViewControllers(currentVCs, animated: animated)
    }
    
    open override func popViewController(animated: Bool) -> UIViewController? {
        let popVC = super.popViewController(animated: animated)
        if let resultVC = popVC as? XYContentController {
            return unWarpNewPushVC(resultVC, needResign: false)
        }
        return nil
    }
    
    open override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        
        if self.viewControllers.contains(viewController) == true { // 在自己vc栈中执行
            let oldSelfViewControllers = self.viewControllers
            
            var newViewControllers: [UIViewController] = []
            for warpedVC in super.viewControllers {
                if warpedVC is XYContentController,
                   let contentVC = warpedVC as? XYContentController {
                    newViewControllers.append(warpedVC)
                    if contentVC.contentVc == viewController {
                        break
                    }
                }
            }
            self.setViewControllers(newViewControllers, animated: animated)
            
            var popedControllers: [UIViewController] = []
            for index in 0..<oldSelfViewControllers.count {
                let popedVC = oldSelfViewControllers[oldSelfViewControllers.count - 1 - index]
                if popedVC == viewController {
                    break
                }
                popedControllers.append(popedVC)
            }
            return popedControllers.reversed()
        }
        return nil
    }
    
    open override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if self.viewControllers.isEmpty {
            return nil
        }
        return popToViewController(self.viewControllers.first!, animated: animated)
    }
    
    
    // MARK: - setViewControllers / getViewControllers
    private func filterVC(vc: UIViewController, inCurrentVCs: [UIViewController]) -> UIViewController {
        let currentVCs = inCurrentVCs
        for currentVC in currentVCs {
            if let contentVC = currentVC as? XYContentController, contentVC.contentVc == vc {
                return contentVC
            }
        }
        return vc
    }
    open override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        var warpedVCs: [UIViewController] = []
        let currentVCs = super.viewControllers
        for vc in viewControllers {
            let desVC = filterVC(vc: vc, inCurrentVCs: currentVCs)
            warpedVCs.append(warpVC(desVC, self, isRootVC: viewControllers.first == vc))
        }
        super.setViewControllers(warpedVCs, animated: animated)
    }
    
    open override var viewControllers: [UIViewController]{
        set{
            var warpedVCs: [UIViewController] = []
            let currentVCs = super.viewControllers
            for vc in newValue {
                let desVC = filterVC(vc: vc, inCurrentVCs: currentVCs)
                warpedVCs.append(warpVC(desVC, self, isRootVC: viewControllers.first == vc))
            }
            super.viewControllers = warpedVCs
        }
        get{
            var resultVCs: [UIViewController] = []
            let warpedVCs = super.viewControllers
            for warpedVC in warpedVCs {
                resultVCs.append(unWarpNewPushVC(warpedVC, needResign: false))
            }
            return resultVCs
        }
    }
    
    // MARK: - visibleViewController/topViewController
    open override var visibleViewController: UIViewController?{
        let visibelVC = super.visibleViewController
        if let contentVC = visibelVC as? XYContentController{
            return contentVC.contentVc
        }else{
            return visibelVC
        }
    }
}

extension XYNavigationController {
    
    /// XYNav 自定义返回 pop 事件
    /// - Returns: 返回最顶部的 viewController
    @objc func popByDefaultAction() -> UIViewController? {
        return self.popViewController(animated: true)
    }
}

extension XYNavigationController : UIGestureRecognizerDelegate{
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGesture {
            if self.viewControllers.count == 1 {
                return false
            }
            
            let point = gestureRecognizer.location(in: gestureRecognizer.view)
            if point.x < (UIScreen.main.bounds.width * self.viewControllers.last!.xy_popGestureRatio) && self.viewControllers.last!.xy_isPopGestureEnable {
                return true
            }
            return false
        }
        
        return false
    }
}

extension UIViewController {
    
    fileprivate struct AssociatedKeys {
        static var isPopGestureEnable: String = "isPopGestureEnable"
        static var popGestureRatio: String = "popGestureRatio"
        static var customNavBarClass: String = "customNavBarClass"
    }
    
    // MARK: - 是否启用侧滑返回功能
    /// 默认支持侧滑返回功能
    @objc public var xy_isPopGestureEnable: Bool {
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.isPopGestureEnable, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            guard let isPopGestureEnable = objc_getAssociatedObject(self, &AssociatedKeys.isPopGestureEnable) as? Bool else {
                return true
            }
            return isPopGestureEnable
        }
    }
    
    /// 支持侧滑返回的比例 0~1
    @objc public var xy_popGestureRatio: CGFloat {
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.popGestureRatio, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            guard let popGestureRatio = objc_getAssociatedObject(self, &AssociatedKeys.popGestureRatio) as? CGFloat else {
                return 0.1
            }
            return popGestureRatio
        }
    }
    
    /// 设置自定义类型的导航栏
    ///
    /// 必须在调用 push方法之前进行设置。默认使用 UINavigationBar
    @objc public var xy_customNavBarClass: AnyClass {
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.customNavBarClass, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            guard let customNavBarClass = objc_getAssociatedObject(self, &AssociatedKeys.customNavBarClass) as? AnyClass else {
                return XYNavBar.self
            }
            return customNavBarClass
        }
    }
}

func getImageWithColor(_ color: UIColor) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
    let ctx = UIGraphicsGetCurrentContext()
    ctx?.setFillColor(color.cgColor)
    ctx?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    return image ?? UIImage()
}
