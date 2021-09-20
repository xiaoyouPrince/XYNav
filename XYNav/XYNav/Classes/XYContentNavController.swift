//
//  XYContentNavController.swift
//  XYNav
//
//  Created by xy on 2021/9/14.
//

import UIKit

class XYContentNavController: UINavigationController {
    
    /// 上级 nav
    weak var superNav: UINavigationController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.superNav is XYNavigationController {
            self.superNav?.pushViewController(viewController, animated: animated)
        }else{
            super.pushViewController(viewController, animated: animated)
        }
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if self.superNav is XYNavigationController {
            return self.superNav?.popViewController(animated: animated)
        }else{
            super.popViewController(animated: animated)
        }
        
        return nil
    }
    
    open override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if self.superNav is XYNavigationController {
            return self.superNav?.popToViewController(viewController,animated: animated)
        }else{
            return super.popToViewController(viewController,animated: animated)
        }
    }
    
    
    open override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if self.superNav is XYNavigationController {
            return self.superNav?.popToRootViewController(animated: animated)
        }else{
            return super.popToRootViewController(animated: animated)
        }
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        if self.superNav is XYNavigationController {
            self.superNav?.setViewControllers(viewControllers, animated: animated)
        }else{
            super.setViewControllers(viewControllers, animated: animated)
        }
    }
    
    override var viewControllers: [UIViewController]{
        set{
//            setViewControllers(newValue, animated: false)
            if self.superNav is XYNavigationController {
                self.superNav?.viewControllers = newValue
            }else{
                super.viewControllers = newValue
            }
        }
        get{
            if self.superNav is XYNavigationController {
                return self.superNav!.viewControllers
            }else{
                return super.viewControllers
            }
        }
    }
    
//    override var topViewController: UIViewController?
//    {
//        get{
//            if self.superNav is XYNavigationController {
//                return superNav?.topViewController
//            }else{
//                return super.topViewController
//            }
//        }
//    }
//    
//    override var visibleViewController: UIViewController?{
//        get {
//            if self.superNav is XYNavigationController {
//                return superNav?.visibleViewController
//            }else{
//                return super.visibleViewController
//            }
//        }
//    }
    
    override var interactivePopGestureRecognizer: UIGestureRecognizer?{
        get {
            if self.superNav is XYNavigationController {
                return self.superNav?.interactivePopGestureRecognizer
            }else{
                return super.interactivePopGestureRecognizer
            }
        }
    }
}
