//
//  XYNavigationController.swift
//  XYNav
//
//  Created by xy on 2021/9/14.
//

import UIKit

fileprivate func warpNewPushVC(_ desVC: UIViewController, _ superNav: XYNavigationController) -> UIViewController {
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

fileprivate func warpVC(_ desVC: UIViewController, _ superNav: XYNavigationController, isRootVC: Bool) -> UIViewController {
    let newVC = warpNewPushVC(desVC, superNav)
    if isRootVC{
        return newVC
    }else{
        newVC.hidesBottomBarWhenPushed = true
        desVC.navigationItem.leftBarButtonItem = UIBarButtonItem(image: getBackImage(), style: .plain, target: superNav, action: #selector(XYNavigationController.popByDefaultAction))
        return newVC
    }
}

fileprivate func unWarpNewPushVC(_ desVC: UIViewController, needResign: Bool) -> UIViewController {
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

fileprivate var backImage: UIImage? = nil
fileprivate func getBackImage() -> UIImage {
    
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

public class XYNavigationController: UINavigationController {
    
    // MARK: - public vars
    var panGesture: UIPanGestureRecognizer?
    private var tempViewControllers: [UIViewController] = []
    
    // MARK: - life circle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        super.interactivePopGestureRecognizer?.isEnabled = false
        panGesture = UIPanGestureRecognizer(target: super.interactivePopGestureRecognizer?.delegate, action: Selector(("handleNavigationTransition:")))
        panGesture!.delegate = self
        view.addGestureRecognizer(panGesture!)
        self.delegate = self
        
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
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        var currentVCs = viewControllers
        currentVCs.append(viewController)
        setViewControllers(currentVCs, animated: animated)
    }
    
    public override func popViewController(animated: Bool) -> UIViewController? {
        let popVC = super.popViewController(animated: animated)
        if let resultVC = popVC as? XYContentController {
            return unWarpNewPushVC(resultVC, needResign: false)
        }
        return nil
    }
    
    public override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        
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
    
    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
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
    public override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        var warpedVCs: [UIViewController] = []
        let currentVCs = super.viewControllers
        for vc in viewControllers {
            let desVC = filterVC(vc: vc, inCurrentVCs: currentVCs)
            warpedVCs.append(warpVC(desVC, self, isRootVC: viewControllers.first == vc))
        }
        super.setViewControllers(warpedVCs, animated: animated)
    }
    
    public override var viewControllers: [UIViewController]{
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
    public override var visibleViewController: UIViewController?{
        let visibelVC = super.visibleViewController
        if let contentVC = visibelVC as? XYContentController{
            return contentVC.contentVc
        }else{
            return visibelVC
        }
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        if let vc = topViewController {
            return vc.preferredStatusBarStyle
        }
        return .default
    }
    
    /// XYNav 自定义返回 pop 事件
    /// - Returns: 返回最顶部的 viewController
    @objc func popByDefaultAction() -> UIViewController? {
        return self.popViewController(animated: true)
    }
}

// MARK: -  拓展一些用户可全局调整的方法
extension XYNavigationController {
    
    static var showClassNameInNavBar: Bool = false
    static var navBarDefaultColor: UIColor?
    
    /// 设置全局返回按钮图标, 默认是 左箭头 <
    /// - Parameter image: 自定义图片
    @objc static public func setDefaultBackImage(_ image: UIImage) {
        let image = image.withRenderingMode(.alwaysOriginal)
        backImage = image
    }
    
    /// 是否在导航栏展示当前 VC 的类名称
    /// - Parameter show: 默认不展示
    /// - Note: 这是一个 DEBUG 环境下特性,  即使设置为展示, 也只在 DEBUG 环境下生效
    @objc static public func showClassNameByDefault(_ show: Bool = false) {
        showClassNameInNavBar = show
    }
    
    /// 设置全局的导航栏颜色
    /// - Parameter barColor: 导航栏本身颜色
    /// - Note: 此属性设置之后会影响导航栏透明效果, 导航栏会变味不透明
    @objc static public func setDefaultBarColor(_ barColor: UIColor) {
        navBarDefaultColor = barColor
    }
    
    /// 对全局导航栏设置几个全局默认效果
    /// - Parameters:
    ///   - backImage: 导航栏返回按钮图标, 默认是 <
    ///   - showClassNameInNavbar: 是否在导航栏展示当前类的名称
    ///   - navBarTintColor: 导航栏的全局背景色
    @objc static public func nav_setGlobal(backBtnImage: UIImage? = nil,
                                           showClassNameInNavbar: Bool = false,
                                           navBarTintColor: UIColor? = nil) {
        if let backBtnImage = backBtnImage {
            backImage = backBtnImage
        }
        
        showClassNameByDefault(showClassNameInNavbar)
        
        if let navBarTintColor = navBarTintColor {
            setDefaultBarColor(navBarTintColor)
        }
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
                self.tempViewControllers = viewControllers
                return true
            }
            return false
        }
        
        return false
    }
}

extension XYNavigationController {
    
    public override var tabBarItem: UITabBarItem! {
        set{}
        get{
            self.viewControllers.first?.tabBarItem
        }
    }
}

extension XYNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if #available(iOS 10.0, *) {
            let beforeControllers = self.tempViewControllers
            viewController.transitionCoordinator?.notifyWhenInteractionChanges({ context in
                if context.isCancelled { return }
                let afterControllers = self.viewControllers
                if beforeControllers.count > afterControllers.count, let poped = beforeControllers.last { // pop last
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: NSNotification.Name("XYNavGesturePopNotification"), object: poped)
                    }
                }
            })
        } else {
            // Fallback on earlier versions
        }
    }
}
