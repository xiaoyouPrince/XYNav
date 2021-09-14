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
            self.superNav?.pushViewController(viewController, animated: true)
        }else{
            super.pushViewController(viewController, animated: animated)
        }
    }
}
