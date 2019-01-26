//
//  Engine.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 12/7/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

let engine = Engine.sharedInstance;

class Engine {
    
    static let sharedInstance = Engine();
    private init () {}
    
}

extension Engine {
    func login(username: String?, password: String?,deviceId: String?, notif: String?, callback: Return<OAuthObj?>?) {
        let param = ["username": username as Any, "password": password as Any,"device_id": deviceId as Any, "notif_token": notif as Any];
        net.request(method: .post, url: Url.login, param: param) {
            locker.oauth = OAuthObj($0);
            print("DATA LOCKER: \(locker.oauth?.authorization?.apiToken)")
            callback?(OAuthObj($0));
            
        }
    }
    
    func getInboxes(callback: Return<InboxObj?>? = nil){
        net.request(url: Url.inboxes){
            callback? (InboxObj(obj: $0))
        }
    }
    
    static func getHeadAgenda(start: Date, end: Date, callback:Return<AgendaModel?>? = nil) {
        net.request(url: Url.headAgendasByRange(startDate: start, endDate: end)) {
            callback? (AgendaModel(obj: $0))
        }
    }
    
//    static func getAttendanceSubject(callback: Return<AttendancesObj?>? = nil){
//        makeRequestAlamofireModel(url: Url.attendanceSubject) {
//            callback? (AttendancesObj(obj: $0))
//        }
//    }
    
    
}
