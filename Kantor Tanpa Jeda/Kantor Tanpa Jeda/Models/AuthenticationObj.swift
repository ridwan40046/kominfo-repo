//
//  AuthenticationObj.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 12/11/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
class AuthenticationObj: BaseModel {
    
    var apiToken : String? { return self[#function.snake] as? String; }
    var code : String? { return self[#function.snake] as? String; }
    var apiTokenExpiration: Date? { return (self[#function.snake] as? Int)?.date; }
}
