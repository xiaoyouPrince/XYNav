//
//  XYContentNavController.swift
//  XYNav
//
//  Created by xy on 2021/9/14.
//

import UIKit

class XYContentNavController: UINavigationController {
    
    /// 上级 nav
    weak var superNav: XYNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.systemBackground
            navigationBar.scrollEdgeAppearance = appearance
        } else {}
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.superNav != nil {
            self.superNav?.pushViewController(viewController, animated: animated)
        }else{
            super.pushViewController(viewController, animated: animated)
        }
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if self.superNav != nil {
            return self.superNav?.popViewController(animated: animated)
        }else{
            super.popViewController(animated: animated)
        }
        return nil
    }
    
    open override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if self.superNav != nil {
            return self.superNav?.popToViewController(viewController,animated: animated)
        }else{
            return super.popToViewController(viewController,animated: animated)
        }
    }
    
    open override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if self.superNav != nil {
            return self.superNav?.popToRootViewController(animated: animated)
        }else{
            return super.popToRootViewController(animated: animated)
        }
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        if self.superNav != nil  {
            self.superNav?.setViewControllers(viewControllers, animated: animated)
        }else{
            super.setViewControllers(viewControllers, animated: animated)
        }
    }
    
    override var viewControllers: [UIViewController]{
        set{
            if self.superNav != nil {
                self.superNav?.viewControllers = newValue
            }else{
                super.viewControllers = newValue
            }
        }
        get{
            if self.superNav != nil {
                return self.superNav!.viewControllers
            }else{
                return super.viewControllers
            }
        }
    }
    
    override var delegate: UINavigationControllerDelegate?{
        set{
            if self.superNav != nil {
                self.superNav?.delegate = newValue
            }else{
                super.delegate = newValue
            }
        }
        get{
            if self.superNav != nil {
                return self.superNav!.delegate
            }else{
                return super.delegate
            }
        }
    }
}

class XYNavBar: UINavigationBar {
    override var barTintColor: UIColor? {
        didSet{
            if #available(iOS 13.0, *) {
                let appearance = UINavigationBarAppearance()
                appearance.backgroundColor = barTintColor
                self.standardAppearance = appearance
                self.scrollEdgeAppearance = appearance
            } else {}
        }
    }
    
    override var isTranslucent: Bool{
        didSet{
            if #available(iOS 13.0, *), isTranslucent == false  {
                barTintColor = barTintColor ?? .systemBackground
            } else {}
        }
    }
}
