//
//  Url.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 12/7/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class Url {
    
    private init() {}
    
    static var main = "http://api-smartoffice.southdev.tech/api/v1";
   // static var oauth = "http://wedding.idesolusiasia.com/oauth/token";
    
    static var login = main + "/login";
    static var register = main + "/register"
    static var inboxes = main + "/inboxes"
    static var me = main + "/me"
}
