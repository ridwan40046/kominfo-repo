//
//  PasscodeVc.swift
//  
//
//  Created by Ridwan Surya Putra on 10/17/18.
//

import Foundation
import UIKit
import SmileLock

class PasscodeVc: BaseVc {
    @IBOutlet var stackView : UIStackView!
    var passwordContainerView: PasswordContainerView!
    let kpassword = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordContainerView = PasswordContainerView.create(in: stackView, digit: 6)
        passwordContainerView.delegate = self
//        passwordContainerView.deleteButtonLocalizedTitle = "Delete"
        
        //customize password UI
        passwordContainerView.tintColor = UIColor.black
        passwordContainerView.highlightedColor = UIColor.black
    }
}

extension PasscodeVc: PasswordInputCompleteProtocol {
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        if validation(input) {
            validationSuccess()
        } else {
            validationFail()
        }
    }
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
        if success {
            self.validationSuccess()
        } else {
            passwordContainerView.clearInput()
        }
    }
}

private extension PasscodeVc {
    func validation(_ input: String) -> Bool {
        return input == "123456"
    }
    
    func validationSuccess() {
        print("*️⃣ success!")
        dismiss(animated: true, completion: nil)
    }
    
    func validationFail() {
        print("*️⃣ failure!")
        passwordContainerView.wrongPassword()
    }
}
