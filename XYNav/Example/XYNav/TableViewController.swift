//
//  TableViewController.swift
//  XYNav_Example
//
//  Created by 渠晓友 on 2021/9/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class TableViewController: BaseViewController {
    
    var transitionContext: UIViewControllerContextTransitioning?
    var customTransion = false
    var tableView: UITableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if customTransion {
            self.navigationController?.delegate = self
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if customTransion {
            self.navigationController?.delegate = nil
        }
    }
}

extension TableViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = "Row: \(indexPath.row)"
        if customTransion {
            cell?.textLabel?.text = "Row: \(indexPath.row)" + " 点我自定义转场"
        }
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if customTransion {
            let detail = RedViewController()
            detail.title = "Row: \(indexPath.row)"
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
}


extension TableViewController: UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            return self
        }
        return nil
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let containerView = self.transitionContext?.containerView
        containerView?.subviews.last?.removeFromSuperview()
        self.transitionContext?.completeTransition(true)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        TimeInterval(UINavigationController.hideShowBarDuration)
        return 3.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!
        let tmpView = toVC.view.snapshotView(afterScreenUpdates: true)!
    
        containerView.addSubview(fromVC.view)
        containerView.addSubview(toVC.view)
        containerView.addSubview(tmpView)
        
        containerView.setNeedsLayout()
        containerView.layoutIfNeeded()
    
        let ScreenW = UIScreen.main.bounds.width
        let ScreenH = UIScreen.main.bounds.height
        let rect = CGRect(x: 50, y: ScreenH - 50, width: 2, height: 2)
        
        let startPath = UIBezierPath(rect: rect)
//        let endPath = UIBezierPath(arcCenter: containerView.center, radius: sqrt(ScreenH * ScreenH + ScreenW * ScreenW), startAngle: 0, endAngle: .pi/2, clockwise: true)
        let endPath = UIBezierPath(rect: UIScreen.main.bounds)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = endPath.cgPath
        tmpView.layer.mask = maskLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.delegate = self

        animation.fromValue = startPath.cgPath
        animation.toValue = endPath.cgPath
        animation.duration = self.transitionDuration(using: transitionContext)
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        maskLayer.add(animation, forKey: "path")
        self.transitionContext = transitionContext
        
//        toVC.view.alpha = 0
//        UIView.transition(with: containerView, duration: transitionDuration(using: transitionContext), options: .curveLinear) {
//            toVC.view.alpha = 1
//        } completion: { (finish) in
//            containerView.subviews.last?.removeFromSuperview()
//            transitionContext.completeTransition(true)
//        }
    }
}
