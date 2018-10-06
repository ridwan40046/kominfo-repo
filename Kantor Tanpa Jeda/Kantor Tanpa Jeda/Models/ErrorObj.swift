//
//  ErrorObj.swift
//  Family Tree
//
//  Created by Martin Tjandra on 2/7/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit

class ErrorObj : BaseModel {
    
    var register : ErrorRegisterObj? { return ErrorRegisterObj(self); }
    var confirmationCode : ErrorConfirmationCodeObj? { return ErrorConfirmationCodeObj(self); }

}

class ErrorRegisterObj : BaseModel {
    
    var firstname       : ArrString? { return self[#function.snake] as? ArrString; }
    var lastname        : ArrString? { return self[#function.snake] as? ArrString; }
    var email           : ArrString? { return self[#function.snake] as? ArrString; }
    var dob             : ArrString? { return self[#function.snake] as? ArrString; }
    var password        : ArrString? { return self[#function.snake] as? ArrString; }
    var confirmPassword : ArrString? { return self[#function.snake] as? ArrString; }

}

class ErrorConfirmationCodeObj : BaseModel {
    
    var confirmCode : ArrString? { return self[#function] as? ArrString; } // yes this is correct, no snakecase.
    
}
