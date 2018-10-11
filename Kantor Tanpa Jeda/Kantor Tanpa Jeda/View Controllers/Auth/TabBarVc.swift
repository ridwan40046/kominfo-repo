//
//  TabBarVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 10/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import UIKit

class TabBarVc: UITabBarController {
    static var synth : TabBarVc { return (UITabBarController.instantiate(named: "TabBarVc") as! TabBarVc); }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = UIColor(red: 17.0/255.0, green: 70.0/255.0, blue: 95.0/255.0, alpha: 0.4)
        } else {
          // Fallback on earlier versions
        }
        self.tabBar.barTintColor = UIColor.white
        
        self.tabBar.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
}
