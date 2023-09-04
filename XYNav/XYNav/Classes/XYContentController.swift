//
//  XYContentController.swift
//  XYNav
//
//  Created by 渠晓友 on 2021/9/18.
//

import UIKit

class XYContentController: UIViewController {
    weak var contentNav: XYContentNavController?
    weak var contentVc: UIViewController?
    
    override func viewDidLoad() {
        print("XYContentController.viewDidLoad")
    }
    
    override var description: String{
        get{
            """
                ---<XYContentController>---
                    contentNav"\(String(describing: contentNav))"
                    contentVc"\(String(describing: contentVc))"
                ---<XYContentController>---
            """
        }
    }
    
    deinit {
        self.contentNav?.superNav?.panGesture?.isEnabled = self.contentNav?.superNav?.viewControllers.last?.xy_isPopGestureEnable ?? true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let contentVC = contentVc {
            return contentVC.preferredStatusBarStyle
        }
        return .default
    }
}
