//
//  InfoJadwalVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 13/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit
class InfoJadwalVc: UIViewController {
    
    
    @IBOutlet weak var viewBtnHijau: UIView!
    @IBOutlet weak var viewBtnMerah: UIView!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var lblSetuju: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblSetuju.makeRoundedRect(withCornerRadius: 10)
        viewBtnHijau.makeRoundedRect(withCornerRadius: 10)
        viewBtnMerah.makeRoundedRect(withCornerRadius: 10)
    }
    @IBAction func btnCrossedTapped(_ sender: UIButton) {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}
