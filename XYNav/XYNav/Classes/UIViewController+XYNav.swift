//
//  UIViewController+XYNav.swift
//  XYNav
//
//  Created by 渠晓友 on 2023/6/13.
//

import Foundation

public extension UIViewController {
    
    fileprivate struct AssociatedKeys {
        static var isPopGestureEnable: String = "isPopGestureEnable"
        static var popGestureRatio: String = "popGestureRatio"
        static var customNavBarClass: String = "customNavBarClass"
        static var customNavBackAction: String = "customNavBackAction"
    }
    
    // MARK: - 是否启用侧滑返回功能
    /// 默认支持侧滑返回功能
    @objc
    var xy_isPopGestureEnable: Bool {
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
    @objc
    var xy_popGestureRatio: CGFloat {
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
    @objc
    var xy_customNavBarClass: AnyClass {
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
    
    
    /// 控制器拓展一个便捷 push 其他控制的方法
    /// - Parameters:
    ///   - viewController: 目标控制器
    ///   - animated: 是否动画
    @objc
    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    /// 导航条隐藏默认的返回按钮
    /// - note: 仅视觉上隐藏,返回功能和点击事件保留.
    @objc
    func nav_hideDefaultBackBtn() {
        if let barTintColor = navigationController?.navigationBar.barTintColor {
            navigationController?.navigationBar.tintColor = barTintColor
        } else {
            navigationController?.navigationBar.tintColor = .clear
        }
    }
    
    /// 设置导航栏底部的横线隐藏/展示
    /// - Parameter hide: ture 表示隐藏, false 为展示, 默认是true
    @objc
    func nav_hideBarBottomLine(_ hide: Bool = true) {
        func hideLine(view: UIView) {
            let subviews = view.subviews.reversed()
            if subviews.isEmpty == true { return }
            
            for subview in subviews {
                if subview.bounds.height <= 1 {
                    subview.isHidden = hide
                    continue
                }
                hideLine(view: subview)
            }
        }
        
        if let bar = navigationController?.navigationBar {
            hideLine(view: bar)
        }
    }
    
    /// 外界设置的自定义的返回事件
    /// 返回值表示是否完成, true 自定义事件完成不中断, false 自定义事件未完成,中断事件
    private var customNavBackAction: ()->Bool {
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.customNavBackAction, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            guard let customNavBackAction = objc_getAssociatedObject(self, &AssociatedKeys.customNavBackAction) as? ()->Bool else {
                return {true} // default is ture
            }
            return customNavBackAction
        }
    }
    
    /// 设置自定义的返回按钮图片, 并设置一个点击回调
    /// - Parameters:
    ///   - backImage: 自定义返回按钮
    ///   - callback: 自定义返回事件, 按钮点击的时候callback执行, 调用方需要返回自定义方法是否符合条件执行完成.
    ///     - callback 返回值 true 表示自定义方法完成, 后续执行 pop
    ///     - 返回值为 false 表示自定义方法未完成, 中断 pop
    @objc
    func nav_setCustom(backImage: UIImage?, callback: (()->Bool)?){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(customBackAction_private))
        
        if let callback = callback {
            customNavBackAction = callback
        }
    }
    
    @objc
    private func customBackAction_private(){
        if customNavBackAction() {
            navigationController?.popViewController(animated: true)
        }
    }
}
