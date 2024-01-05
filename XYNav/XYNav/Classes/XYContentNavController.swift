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
        
        if let globalBarTintColor = XYNavigationController.navBarDefaultColor {
            navigationBar.barTintColor = globalBarTintColor
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if DEBUG
        if let vc = topViewController, XYNavigationController.showClassNameInNavBar {
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
                self.compactAppearance = appearance
                self.scrollEdgeAppearance = appearance
                
                if #available(iOS 15.0, *) {
                    let appearance = UINavigationBarAppearance()
                    appearance.backgroundColor = barTintColor
                    self.compactScrollEdgeAppearance = appearance
                }
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
