//
//  OauthObj.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 12/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class OAuthObj : BaseModel {
    var userDetail: UserObj? { return UserObj(self[#function.capitalized]); }
    var authorization: AuthenticationObj? { return AuthenticationObj(self[#function.snake])}
//    enum TokenType : String { case bearer = "Bearer"; }
//    var tokenType : String? { return self[#function.snake] as? String; }
//    var tokenTypeEnum : TokenType? { return TokenType.init(rawValue: tokenType ?? ""); }
//
//    var expiresIn : TimeInterval? { return self[#function.snake] as? TimeInterval; }
//    var expiresFrom : Date? { // manual add
//        get { return self[#function.snake] as? Date; }
//        set { self[#function.snake] = (newValue ?? Date()) as AnyObject; }
//    }
//    var expiresDate : Date? {
//        guard let expiresIn = expiresIn else { return nil; }
//        return expiresFrom?.addingTimeInterval(expiresIn);
//    }
//    var issuedAt: Date? { return (self[#function.snake] as? Int)?.date; }
//    var accessToken : String? { return self[#function.snake] as? String; }
//    var refreshToken : String? { return self[#function.snake] as? String; }
//    var idString: String? { return self["id"] as? String; }
}
