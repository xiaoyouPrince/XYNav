//
//  XYTabbarController.swift
//  XYNav
//
//  Created by 渠晓友 on 2024/1/6.
//

import UIKit

@available(iOS 13.0, *)
@objcMembers public class XYTabbarContent: NSObject {
    var vc: UIViewController
    var title: String
    var image: String
    var selectedImage: String
    
    public init(vc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        self.vc = vc
        self.title = title
        self.image = imageName
        self.selectedImage = selectedImageName
    }
}

@available(iOS 13.0, *)
@objc public class XYTabbarController: UITabBarController {
    
    /// UI mode, default is fellow system
    private var uiStyle: UIUserInterfaceStyle = .unspecified
    /// 选中 Item.tintColor
    private var selectedItemTintColor: UIColor?
    /// tabarBgColor
    private var tabbarBgColor: UIColor?
    /// tabbarBgImage
    private var tabbarBgImage: UIImage?
    private var tabbarContentCallbak: (() -> [XYTabbarContent])?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 指定初始化方法
    /// - Parameters:
    ///   - uiStyle: 支持的mode, light / dark,  default is fellow the system
    ///   - barTintColor: 选中 item.title 的颜色
    ///   - barBgColor: tabBar 的背景色,  default is nil, default is fellow the system
    ///   - barBgImage: tabBar 的背景图片,  default is nil, default is fellow the system
    @objc public init(with uiStyle: UIUserInterfaceStyle = .unspecified,
                      selectedItemTintColor: UIColor? = nil,
                      tabbarBgColor: UIColor? = nil,
                      tabbarBgImage: UIImage? = nil,
                      tabbarContentCallbak: @escaping () -> [XYTabbarContent]) {
        self.uiStyle = uiStyle
        self.selectedItemTintColor = selectedItemTintColor
        self.tabbarBgColor = tabbarBgColor
        self.tabbarBgImage = tabbarBgImage
        self.tabbarContentCallbak = tabbarContentCallbak
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = uiStyle
        setTabbar()
        setupTabbarContent()
    }
    
    private func setTabbar() {
        self.tabBar.tintColor = self.selectedItemTintColor
        self.tabBar.barTintColor = tabbarBgColor
        self.tabBar.isTranslucent = true;
        
        //if #available(iOS 13.0, *) {
        let tabarAppearnce = UITabBarAppearance()
        tabarAppearnce.backgroundColor = tabbarBgColor
        tabarAppearnce.backgroundImage = tabbarBgImage
        self.tabBar.standardAppearance = tabarAppearnce
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = tabarAppearnce
        } else {
            // Fallback on earlier versions
        }
        //}
    }
    
    private func setupTabbarContent() {
        if let tabbarContentCallbak = tabbarContentCallbak {
            for item in tabbarContentCallbak() {
                addChildViewController(childVc: item.vc, title: item.title, imageName: item.image, seletImageName: item.selectedImage)
            }
        }
    }
    
    private func addChildViewController( childVc: UIViewController, title: String, imageName: String, seletImageName: String) {
        childVc.title = title
        childVc.navigationItem.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childVc.tabBarItem.selectedImage = UIImage(named: seletImageName)?.withRenderingMode(.alwaysOriginal)
        let childNav = XYNavigationController(rootViewController: childVc)
        addChild(childNav)
    }
}
