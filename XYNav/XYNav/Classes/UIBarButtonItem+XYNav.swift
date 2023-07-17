//
//  UIBarButtonItem+XYNav.swift
//  XYNav
//
//  Created by 渠晓友 on 2023/7/9.
//

import Foundation

@objc public extension UIBarButtonItem {
    /// 创建一个带有图片的 UIBarButtonItem
    ///
    /// - Parameters:
    ///   - target: 目标对象
    ///   - action: 响应方法
    ///   - image: 图片
    /// - Returns: UIBarButtonItem 对象
    class func xy_item(withTarget target: AnyObject, action: Selector, image: UIImage?) -> UIBarButtonItem {
        return xy_item(withTarget: target, action: action, nomalImage: image, higeLightedImage: nil, imageEdgeInsets: .zero)
    }
    
    /// 创建一个带有图片的 UIBarButtonItem
    ///
    /// - Parameters:
    ///   - target: 目标对象
    ///   - action: 响应方法
    ///   - image: 图片
    ///   - imageEdgeInsets: 图片的内边距
    /// - Returns: UIBarButtonItem 对象
    class func xy_item(withTarget target: AnyObject, action: Selector, image: UIImage?, imageEdgeInsets: UIEdgeInsets) -> UIBarButtonItem {
        return xy_item(withTarget: target, action: action, nomalImage: image, higeLightedImage: nil, imageEdgeInsets: imageEdgeInsets)
    }
    
    /// 创建一个带有图片的 UIBarButtonItem
    ///
    /// - Parameters:
    ///   - target: 目标对象
    ///   - action: 响应方法
    ///   - nomalImage: 正常状态下的图片
    ///   - higeLightedImage: 高亮状态下的图片
    ///   - imageEdgeInsets: 图片的内边距
    /// - Returns: UIBarButtonItem 对象
    class func xy_item(withTarget target: AnyObject, action: Selector, nomalImage: UIImage?, higeLightedImage: UIImage?, imageEdgeInsets: UIEdgeInsets) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        button.setImage(nomalImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        if let highlightedImage = higeLightedImage {
            button.setImage(highlightedImage, for: .highlighted)
        }
        button.sizeToFit()
        if button.bounds.size.width < 40 {
            let width = 40 / button.bounds.size.height * button.bounds.size.width
            button.bounds = CGRect(x: 0, y: 0, width: width, height: 40)
        }
        button.imageEdgeInsets = imageEdgeInsets
        return UIBarButtonItem(customView: button)
    }
    
    /// 创建一个带有标题的 UIBarButtonItem
    ///
    /// - Parameters:
    ///   - target: 目标对象
    ///   - action: 响应方法
    ///   - title: 标题
    /// - Returns: UIBarButtonItem 对象
    class func xy_item(withTarget target: AnyObject, action: Selector, title: String?) -> UIBarButtonItem {
        return xy_item(withTarget: target, action: action, title: title, font: nil, titleColor: nil, highlightedColor: nil, titleEdgeInsets: .zero)
    }
    
    /// 创建一个带有标题的 UIBarButtonItem
    ///
    /// - Parameters:
    ///   - target: 目标对象
    ///   - action: 响应方法
    ///   - title: 标题
    ///   - titleEdgeInsets: 标题的内边距
    /// - Returns: UIBarButtonItem 对象
    class func xy_item(withTarget target: AnyObject, action: Selector, title: String?, titleEdgeInsets: UIEdgeInsets) -> UIBarButtonItem {
        return xy_item(withTarget: target, action: action, title: title, font: nil, titleColor: nil, highlightedColor: nil, titleEdgeInsets: titleEdgeInsets)
    }
    
    /// 创建一个带有标题的 UIBarButtonItem
    ///
    /// - Parameters:
    ///   - target: 目标对象
    ///   - action: 响应方法
    ///   - title: 标题
    ///   - font: 标题的字体
    ///   - titleColor: 标题的颜色
    ///   - highlightedColor: 高亮状态下的标题颜色
    ///   - titleEdgeInsets: 标题的内边距
    /// - Returns: UIBarButtonItem 对象
    class func xy_item(withTarget target: AnyObject, action: Selector, title: String?, font: UIFont?, titleColor: UIColor?, highlightedColor: UIColor?, titleEdgeInsets: UIEdgeInsets) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        button.setTitleColor(titleColor ?? UIColor.black, for: .normal)
        button.setTitleColor(highlightedColor ?? UIColor.black, for: .highlighted)
        
        button.sizeToFit()
        if button.bounds.size.width < 40 {
            let width = 40 / button.bounds.size.height * button.bounds.size.width
            button.bounds = CGRect(x: 0, y: 0, width: width, height: 40)
        }
        button.titleEdgeInsets = titleEdgeInsets
        return UIBarButtonItem(customView: button)
    }
    
    /// 创建一个固定宽度的 UIBarButtonItem
    ///
    /// - Parameter width: 固定的宽度
    /// - Returns: UIBarButtonItem 对象
    class func xy_fixedSpace(withWidth width: CGFloat) -> UIBarButtonItem {
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = width
        return fixedSpace
    }
}


