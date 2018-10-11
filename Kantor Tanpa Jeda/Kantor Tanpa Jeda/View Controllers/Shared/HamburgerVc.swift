//
//  HamburgerVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 12/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit
class HamburgerVc: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnCrossTapped(_ sender: UIButton) {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    @IBAction func btnBantuanTapped(_ sender: UIButton) {
        toast("Bantuan")
    }
    
    @IBAction func btnHalamanMuka(_ sender: UIButton) {
        toast("halaman muka")
    }
    
    
}
