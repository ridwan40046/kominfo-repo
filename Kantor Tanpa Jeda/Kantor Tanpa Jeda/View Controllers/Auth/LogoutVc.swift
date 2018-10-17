//
//  LogoutVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 10/16/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class LogoutVc: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
//            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginVc") as! LoginVc
            let viewController = UIViewController.instantiate(named: "NavigationVc") as? NavigationVc
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
}
