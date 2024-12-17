//
//  ViewController.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/17/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
         self.navigationController!.pushViewController(vc, animated: true)
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }


}

