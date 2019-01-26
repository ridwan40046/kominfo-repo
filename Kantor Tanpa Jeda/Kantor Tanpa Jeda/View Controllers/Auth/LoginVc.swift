//
//  LoginVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 10/8/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import UIKit
import Foundation

class LoginVc: UIViewController {
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    var inbox: InboxObj?
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.makeRoundedRect(withCornerRadius: 5)
        btnRegister.makeRoundedRect(withCornerRadius: 5)
        btnRegister.layer.borderWidth = 1
        btnRegister.layer.borderColor = UIColor.blueButton.cgColor
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLoginTapped(_ sender: UIButton) {
        engine.login(username: "waya003", password: "12345678",deviceId: "12345678", notif: "12345678"){
            if $0?.isSuccess ?? false{
                DispatchQueue.main.async {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarVc") as! TabBarVc
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
            }else {
                print("eror")
                toast("cannot login please check you username or password")
            }
        }
   
    }
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
        let vc = UIViewController.instantiate(named: "DaftarVc") as? DaftarVc
        vc?.show(currentVc: self)
        engine.getInboxes(){
            if $0?.isSuccess ?? false {
                self.inbox = $0
            }else {
                print("gagal")
            }
        }
//        DispatchQueue.main.async {
//            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "Testing") as! TestingDropdown
//            UIApplication.shared.keyWindow?.rootViewController = viewController
//        }
    }
    
  
}
