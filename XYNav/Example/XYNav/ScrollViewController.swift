//
//  ScrollViewController.swift
//  XYNav_Example
//
//  Created by 渠晓友 on 2021/9/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class ScrollViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.xy_popGestureRatio = 1.0
        view.backgroundColor = UIColor.groupTableViewBackground
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.lightGray
        view.addSubview(scrollView)
        
        let img = UIImage(named: "15949966411425")
        let imgIV = UIImageView(image:img)
        scrollView.addSubview(imgIV)
        scrollView.contentSize = img!.size
    }

}
