//
//  BaseVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 11/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class BaseVc: UIViewController {
    var currentBaseVc: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBar()
    }
    
    func show(currentVc: UIViewController){
        currentVc.navigationController?.pushViewController(self, animated: true)
        self.currentBaseVc = currentVc
    }
    
    @objc func hamburger(){
        Util.showHamburger(currentVc: self)
    }
    
    func setNavBar(){
        let back = UIBarButtonItem()
        back.title = "Kembali"
        currentBaseVc?.navigationItem.backBarButtonItem = back
        let btnKanan = UIBarButtonItem(image: UIImage(named: "hamburger.png")?.resize(20, 20), style: .done, target: self, action: #selector(hamburger))
        self.navigationItem.setRightBarButtonItems([btnKanan], animated: false)
    }
}
