//
//  LaporanVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 17/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class LaporanVc: BaseVc {
    
    override func setNavBar() {
        let back = UIBarButtonItem()
        back.title = "Kembali"
        self.currentBaseVc?.navigationItem.backBarButtonItem = back
        let btnKanan = UIBarButtonItem(image: UIImage(named: "hamburger.png")?.resize(20, 20), style: .done, target: self, action: #selector(hamburger))
        
        let btnFilter = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: nil)
        
        self.navigationItem.setRightBarButtonItems([btnKanan, btnFilter], animated: false)
    }
}

