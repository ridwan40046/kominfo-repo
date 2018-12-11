//
//  UserObj.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 12/11/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class UserObj: BaseModel {
    var code : String? { return self[#function] as? String; }
    var name : String? { return self[#function] as? String; }
    var position : String? { return self[#function] as? String; }
    var positionGroup : String? { return self[#function] as? String; }
    var positionLevel : String? { return self[#function] as? String; }
    var employeeStatus : String? { return self[#function] as? String; }
    var gender : String? { return self[#function] as? String; }
    var nip : String? { return self[#function] as? String; }
    var nik : String? { return self[#function] as? String; }
    var mobileNumber : String? { return self[#function] as? String; }
    var address : String? { return self[#function] as? String; }
    var email : String? { return self[#function] as? String; }
    var birthDate : String? { return self[#function] as? String; }
    var avatarUrl : String? { return self[#function] as? String; }
    var p12File : String? { return self[#function] as? String; }
}
