//
//  CusNavBar.swift
//  XYNav_Example
//
//  Created by 渠晓友 on 2021/9/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class CusNavBar: UINavigationBar {

    override func draw(_ rect: CGRect) {
        
        ("我是自定义的NavBar" as NSString).draw(in: rect.inset(by: UIEdgeInsets(top: 13, left: 60, bottom: 0, right: -30)), withAttributes: [.font : UIFont.boldSystemFont(ofSize: 18), .foregroundColor : UIColor.red])
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 5)
        UIColor.red.set()
        path.lineWidth = 3
        path.stroke()
    }

}
