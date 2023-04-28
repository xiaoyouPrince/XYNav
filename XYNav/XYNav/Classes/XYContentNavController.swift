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
    private var statusBar = CustomStatusBar(frame: CGRect.init(origin: .zero, size: CGSize.init(width: UIScreen.main.bounds.width, height: 10)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.systemBackground
            navigationBar.scrollEdgeAppearance = appearance
        } else {}
        
        navigationBar.addSubview(statusBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if DEBUG
        if let vc = topViewController {
            statusBar.setMsg(with: vc)
        }
        #endif
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

class CustomStatusBar: UIView {
    private var messageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(messageLabel)
        messageLabel.font = UIFont.systemFont(ofSize: 10)
        messageLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMsg(with vc: UIViewController) {
        messageLabel.text = type(of: vc).description()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        messageLabel.frame = bounds
    }
}













//-----------------------------------

//class XYContentNavController: UINavigationController {
//
//    /// 上级 nav
//    weak var superNav: XYNavigationController?
//    private let statusBar = CustomStatusBar(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 10)))
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if #available(iOS 15.0, *) {
//            let appearance = UINavigationBarAppearance()
//            appearance.backgroundColor = UIColor.systemBackground
//            navigationBar.scrollEdgeAppearance = appearance
//        }
//
//        navigationBar.addSubview(statusBar)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        #if DEBUG
//        if let vc = topViewController {
//            statusBar.setMsg(with: vc)
//        }
//        #endif
//    }
//
//    private func callSuperMethod<T>(_ method: (XYNavigationController) -> T?, defaultValue: T) -> T {
//        if let superNav = superNav, let result = method(superNav) {
//            return result
//        } else {
//            return defaultValue
//        }
//    }
//
//    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        callSuperMethod({ $0.pushViewController(viewController, animated: animated) }, defaultValue: super.pushViewController(viewController, animated: animated))
//    }
//
//    override func popViewController(animated: Bool) -> UIViewController? {
//        callSuperMethod({ $0.popViewController(animated: animated) }, defaultValue: super.popViewController(animated: animated))
//    }
//
//    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
//        callSuperMethod({ $0.popToViewController(viewController, animated: animated) }, defaultValue: super.popToViewController(viewController, animated: animated))
//    }
//
//    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
//        callSuperMethod({ $0.popToRootViewController(animated: animated) }, defaultValue: super.popToRootViewController(animated: animated))
//    }
//
//    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
//        callSuperMethod({ $0.setViewControllers(viewControllers, animated: animated) }, defaultValue: super.setViewControllers(viewControllers, animated: animated))
//    }
//
//    override var viewControllers: [UIViewController]{
//        set{
//            callSuperMethod({ $0.viewControllers = newValue }, defaultValue: super.viewControllers = newValue)
//        }
//        get{
//            callSuperMethod({ $0.viewControllers }, defaultValue: super.viewControllers)
//        }
//    }
//
//    override var delegate: UINavigationControllerDelegate?{
//        set{
//            callSuperMethod({ $0.delegate = newValue }, defaultValue: super.delegate = newValue)
//        }
//        get{
//            callSuperMethod({ $0.delegate }, defaultValue: super.delegate)
//        }
//    }
//}
//
//class XYNavBar: UINavigationBar {
//    override var barTintColor: UIColor? {
//        didSet{
//            if #available(iOS 13.0, *) {
//                let appearance = UINavigationBarAppearance()
//                appearance.backgroundColor = barTintColor
//                self.standardAppearance = appearance
//                self.scrollEdgeAppearance = appearance
//            }
//        }
//    }
//
//    override var isTranslucent: Bool{
//        didSet{
//            if #available(iOS 13.0, *), isTranslucent == false  {
//                barTintColor = barTintColor ?? .systemBackground
//            }
//        }
//    }
//}
//
//class CustomStatusBar: UIView {
//    private let messageLabel = UILabel()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(messageLabel)
//        messageLabel.font = UIFont.systemFont(ofSize: 10)
//        messageLabel.textAlignment = .center
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setMsg(with vc: UIViewController) {
//        messageLabel.text = statusBarText(for: vc)
//    }
//
//    private func statusBarText(for vc: UIViewController) -> String {
//        return "\(type(of: vc))"
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        messageLabel.frame = bounds
//    }
//}
