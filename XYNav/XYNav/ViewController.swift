//
//  ViewController.swift
//  XYNav
//
//  Created by xy on 2021/9/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func push(_ sender: Any) {
        
        let contVC = UIViewController()
        contVC.view.backgroundColor = .groupTableViewBackground
        self.navigationController?.pushViewController(contVC, animated: true)
    }
    
    
    @IBAction func push2(_ sender: Any) {
        
        let contVC = DestViewController()
        self.navigationController?.pushViewController(contVC, animated: true)
    }
}

