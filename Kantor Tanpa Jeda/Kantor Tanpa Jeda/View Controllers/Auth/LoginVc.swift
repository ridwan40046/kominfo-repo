//
//  LoginVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 10/8/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import UIKit

class LoginVc: UIViewController {
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.makeRoundedRect(withCornerRadius: 5)
        btnRegister.makeRoundedRect(withCornerRadius: 5)
        btnRegister.layer.borderWidth = 1
        btnRegister.layer.borderColor = UIColor.blueButton.cgColor
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLoginTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarVc") as! TabBarVc
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
    
    @IBOutlet weak var btnRegisterTapped: UIButton!
}
