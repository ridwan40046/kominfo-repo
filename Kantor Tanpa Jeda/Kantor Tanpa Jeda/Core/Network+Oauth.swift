//
//  Network+Oauth.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 12/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

extension Network {
    
    var clientId : String { return "12345678"; }
    var clientUsername : String { return "waya003"; }
    var clientPassword : String { return "12345678"; }
    var notifId : String { return "843494590"}

    
    /** Use this to login OAuth */
    func newOAuth(callback: Return<OAuthObj?>?) {
        let param = [
            "username": clientUsername,
            "password": clientPassword,
            "device_id": clientId,
<<<<<<< HEAD
            "notif_token": notifId
=======
            "notif_token": "12345678"
>>>>>>> master
        ];
        
        requestBase(method: .post, url: Url.login, param: param as [String: AnyObject]) {
            let oauth = OAuthObj($0);
//            oauth?.expiresFrom = Date();
            locker.oauth = oauth;
            callback?(OAuthObj($0));
        }
    }
    
    //    func refreshOAuth(callback: Return<OAuthObj?>?) {
    //        guard let refreshToken = locker.oauth?.refreshToken else { toast ("No refresh token"); callback?(nil); return; }
    //        let param = [ "grant_type": "refresh_token", "refresh_token": refreshToken ,"client_id": clientId, "client_secret": clientSecret];
    //
    //        requestAlamo(method: .get, url: Url.oauth, param: param as [String: AnyObject]) {
    //            let oauth = OAuthObj($0);
    //            oauth?.expiresFrom = Date();
    //            locker.oauth = oauth;
    //            callback?(OAuthObj($0));
    //        }
    //    }
    
    //    /** Don't use this to login OAuth. Use newOAuth instead. Use this only to fix OAuth. */
    //    func getOAuth(callback: Return<OAuthObj?>?) {
    //        refreshOAuth {
    //            if $0?.isSuccess ?? false { callback?($0); }
    //            else {
    //                self.newOAuth {
    //                    if $0?.isSuccess ?? false { callback?($0); }
    //                    else { toastUser ("Unable to authenticate to OAuth"); callback?(nil); }
    //                }
    //            }
    //        }
    //    }
    
    
    
}
